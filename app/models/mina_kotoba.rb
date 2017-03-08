class MinaKotoba < ActiveRecord::Base
  ActiveRecord::Base.establish_connection :kanji_b_japanse if Rails.env == "development"
  # scope :top_three, -> { where(lesson_id: LESSONS) }
  scope :top_three, -> { where(stick: true) }
  scope :fetch_quiz, -> { order(updated_at: :asc).limit(4) }
  LESSONS = (26..33).to_a
  PATH = Rails.root
  extend Enumerize
  enumerize :word_type,
    in: %i(i na noun verb),
    scope: true,
    predicates: { prefix: true }

  def self.fetch
    (1..50).each do |i|
      url = "http://mina.mazii.net/api/getKotoba.php?lessonid=#{i}"
      response = Net::HTTP.get(URI(url))
      response = JSON.parse(response)
      self.create(response)
    end
  end
  require 'csv'
  def self.to_csv(options = {})
    file = CSV.open("#{Dir.pwd}/mina-kotoba#{Time.now}.csv", "w") do |csv|
      all.each do |word|
        values = word.attributes
        values["question"] = word.kanji.present? ? "#{word.kanji}(#{word.hiragana}): #{word.mean}" : "#{word.hiragana}: #{word.mean}"
        values["anwser"] = word.kanji.present? ? "#{word.cn_mean}(#{word.roumaji}): #{word.mean}" : "#{word.roumaji}: #{word.mean}"
        csv << values.values_at(*[:question, :anwser, :kanji, :hiragana, :roumaji, :mean, :cn_mean, :lesson_id].map(&:to_s))
      end
    end
  end

  def self.as_json_as(options={})
    transaction do
      all.map do |word|
        word.touch
        word.as_json(:methods => [:quiz_options, :question, :answer])
      end
    end
  end

  def question
    own = self.kanji.present? ? "#{self.kanji}(#{self.hiragana}): #{self.mean}" : "#{self.hiragana}: #{self.mean}"
    own = self.kanji.present? ? "#{self.kanji}(#{self.hiragana})" : "#{self.hiragana}"
  end

  def answer
    self.kanji.present? ? "#{self.cn_mean}(#{self.roumaji}): #{self.mean}" : "#{self.roumaji}: #{self.mean}"
  end
  require 'rest-client'
  require 'nokogiri'
  def suru
    hira = self.hiragana.gsub(/\[.*\]/, "").gsub(/\(.*\)/, "").gsub(/\「.*\」/, "").strip
    p hira
    if hira.romaji[-5..-1] == 'emasu'
      type = 2
    elsif hira.romaji[-5..-1] == 'imasu'
      if hira.romaji[-7..-1] == 'shimasu'
        type = 3
      else
        type = 1
      end
    else
      type = 0
    end
    if type == 1
      r = hira.romaji
      r = r.gsub('imasu', 'u')
      "#{r.hiragana}"
    elsif type == 2
      "#{hira[0..-3]}る"
    elsif type == 3
      w = hira.gsub('を', '')
      "#{w[0..-4]}"
    else
      hira
    end
  end
  require 'open-uri'

  def audio
    ver = suru
    fail = []

    check = if self.audio_link.present?
      true
    else
      pg = RestClient.post 'https://www.japanesepod101.com/learningcenter/reference/dictionary_post', {post: 'dictionary_reference', match_type: 'exact', search_query: "#{ver}", common: true}
      doc = Nokogiri::HTML(pg.body)
      w = doc.css('.ill-onebuttonplayer')
      self.audio_link = w.attribute('data-url').value if w.present?
      self.save
    end

    return self.hiragana if self.audio_link.blank?

    if check
      open("#{PATH}/Todo/audio/#{self.id}-1.mp3", 'wb') do |file|
        file << open(self.audio_link).read
      end
      open("#{PATH}/Todo/audio/all.txt", "w+") do |f|
        (1..100).each do |index|
          url = "#{PATH}/Todo/audio/#{self.id}-1.mp3"
          f.write("file '#{url}'\n") if File.exist?(url)
        end
      end
      make_audio
    else
      fail << self
    end
    p fail
    self.audio_link
  end

  def make_audio
    `#{PATH}/Todo/./ffmpeg -f concat -i #{PATH}/Todo/audio/all.txt -c copy  -metadata 'artist'="#{self.kanji}" -metadata 'title'="#{self.id}-#{suru}: #{self.mean}" -metadata 'album'="MinaKotoba"   #{PATH}/Todo/audio/"#{name}".mp3`
    FileUtils.rm("#{PATH}/Todo/audio/all.txt")
    FileUtils.rm("#{PATH}/Todo/audio/#{self.id}-1.mp3")
  end

  def quiz_options
    options = MinaKotoba.where.not(id: self.id).sample(3).map do |word|
      [word.id, word.kanji.present? ? "#{word.cn_mean}(#{word.roumaji}): #{word.mean}" : "#{word.roumaji}: #{word.mean}"]
      # [word.id, word.mean]
    end
    q = self.kanji.present? ? "#{self.cn_mean}(#{self.roumaji}): #{self.mean}" : "#{self.roumaji}: #{self.mean}"
    # q = "#{self.mean}"
    (options << [self.id, q]).shuffle
  end

  def self.up_stick list
    list.split("\n").map do |w|
      words = MinaKotoba.where('hiragana LIKE  ?', "#{w}")
      words.update_all(stick: true)
      w unless words.present?
    end.compact
  end

  def self.quizlet
    all.each do |w|
      w.cn_mean = w.cn_mean.mb_chars.upcase.to_s if w.cn_mean.present?
      puts "#{w.hiragana}"
      puts "#{w.hiragana.romaji};"
      puts w.kanji
      puts w.cn_mean
      puts "#{w.mean}+"
    end
    false
  end

  def self.export_image folder = nil
    @@folder = folder

    if folder.blank?
      p "Please input name"
      return
    end

    FileUtils::mkdir_p "Todo/#{self.to_s}" unless File.directory?("Todo/#{self.to_s}")

    music = '/Users/THAO-NUS/Dropbox/Job/JapaneseLearning/Todo/Vitalie.mp3'
    folder = "#{Rails.root.to_s}/Todo/#{@@folder}"
    FileUtils::mkdir_p folder

    require 'RMagick'
    self.all.each_with_index do |word, index|
      word.fwrite(index + 1)
    end
    system "Todo/./ffmpeg -framerate 1/3 -i Todo/#{@@folder}/img%03d.png -s:v 1280x720 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p Todo/#{self.to_s}/#{@@folder}.mp4"
    FileUtils.rm_rf("#{folder}")
    # self.update_all(learned: true)
  end

  def fwrite i = 1
    n = i.to_s.rjust(3, "0")
    name = "img#{n}"

    granite = Magick::ImageList.new("#{Rails.public_path.to_s}/1280x720.png")
    canvas = Magick::ImageList.new
    canvas.new_image(1280, 720, Magick::TextureFill.new(granite))

    text = Magick::Draw.new
    text.font = "#{Rails.public_path.to_s}/fonts-japanese-gothic.ttf"
    text.gravity = Magick::CenterGravity

    text.annotate(canvas, 0,0,0,-75, "#{self.kanji.present? ? self.kanji : self.hiragana}") { |txt|
      txt.fill = '#0000ff'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 140
    }

    text.annotate(canvas, 0,0,0,0, "#{self.roumaji}") { |txt|
      txt.fill = '#000000'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 30
    }

    text.annotate(canvas, 0,0,0,50, "#{self.hiragana}") { |txt|
      txt.fill = '#E74C3C'
      txt.pointsize = 60
    }

    mean = breaking_word_wrap("#{self.mean.present? ? self.mean : self.mean}", 30)
    text.annotate(canvas, 0,0,0,135, "#{mean}\n#{self.cn_mean.to_s.mb_chars.upcase.to_s}") { |txt|
      txt.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
      txt.fill = '#555555'
      txt.pointsize = 40
    }

    text.annotate(canvas, 0,0,-460,-330, "#{self.id} - #{self.lesson_id}") { |txt|
      txt.fill = '#000000'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 35
    }

    canvas.write("Todo/#{@@folder}/#{name}.png")
    # canvas.write("#{name}.png")
  end

end
