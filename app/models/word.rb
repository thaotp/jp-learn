require 'csv'
class Word < ActiveRecord::Base
  before_create :set_romanji, :set_kanji, :set_times
  validates_presence_of :name
  # Word.uniq.pluck(:lesson).max(self.max_lesson)
  scope :top_three, -> { where(lesson: self.range_lesson).where(show: true) }
  scope :random, -> { order(updated_at: :asc).limit(1).first }
  scope :not_vn_mean, -> { where(vn_mean: "") }
  scope :fetch_quiz, -> { select(:id, :name, :name_jp, :mean, :kanji_note, :romanji, :kanji, :vn_mean).order(updated_at: :asc).limit(4) }
  def set_romanji
    self.romanji = self.name_jp.romaji
  end

  def set_kanji
    self.kanji = self.name.chars.select(&:kanji?).join(',')
    set_kanji_note
  end

  def set_times
    self.times = 0
  end

  def to_rep
    self.touch
    {title: "#{self.try(:name)} (#{self.name_jp})" || '', message: self.try(:hint) || self.try(:mean), type: 'word'}
  end

  def self.as_json_as(options={})
    transaction do
      all.map do |word|
        word.touch
        word.as_json(:methods => [:quiz_options, :kanji_export])
      end
    end
  end

  def self.max_lesson
    Setting.max_lesson.first.try(:value) || 3
  end

  def self.range_lesson
    # (8..self.max_lesson).to_a
    (1..25).to_a
  end

  def quiz_options
    (Word.where.not(id: self.id).pluck(:name_jp).sample(3) << self.name_jp).shuffle
  end

  def kanji_export
    self.kanji.gsub(',','')
  end

  def self.import_csv(url)
    data = []
    csv_text = File.read(url)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>false)
    csv.each do |row|
      # puts row[1]
      data << {name_jp: row[0], name: row[1], mean: row[2], lesson: row[3]}
    end
    create!(data)
  end

  def self.bulk_import(data, lesson)
    words = []
    data.split("\n").each do |word_group|
      word_groups = word_group.split(" ")
      name = word_groups[0]
      name_jp = word_groups[1]
      mean = word_groups[2..-1].join(' ')
      words << {name: name, name_jp: name_jp, mean: mean, lesson: lesson}
    end
    self.create(words)
  end

  def self.to_csv
    column_names = [:name_jp, :name, :mean, :lesson]

    file = CSV.open("#{Dir.pwd}/csv/bai-#{self.first.try(:lesson)}.csv", "w") do |csv|
      all.each do |word|
        word.name = '' if word.kanji.blank?
        csv << word.attributes.values_at(*column_names.map(&:to_s))
      end
    end
    p "Done ..."
  end

  def self.export_image folder = nil
    @@folder = folder
    if folder.blank?
      p "Please input name"
      return
    end
    folder = "#{Rails.root.to_s}/Todo/#{@@folder}"
    FileUtils::mkdir_p folder

    require 'RMagick'
    self.all.each_with_index do |word, index|
      word.fwrite(index + 1)
    end
    p "Todo/./ffmpeg -framerate 1/3 -i Todo/#{@@folder}/img%03d.png -s:v 1280x720 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p Todo/#{@@folder}/#{@@folder}.mp4"
    self.update_all(learned: true)
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

    text.annotate(canvas, 0,0,0,-60, "#{self.name_jp}") { |txt|
      txt.fill = '#0000ff'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 160
    }

    # text.annotate(canvas, 0,0,0,0, "#{self.romanji}") { |txt|
    #   txt.fill = '#000000'
    #   txt.font_weight = Magick::BoldWeight
    #   txt.pointsize = 30
    # }

    text.annotate(canvas, 0,0,0,50, "#{self.name}") { |txt|
      txt.fill = '#E74C3C'
      txt.pointsize = 60
    }

    mean = breaking_word_wrap("#{self.vn_mean.present? ? self.vn_mean : self.mean}", 30)
    text.annotate(canvas, 0,0,0,135, "#{mean}\n#{self.cn_mean.to_s.mb_chars.upcase.to_s}") { |txt|
      txt.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
      txt.fill = '#555555'
      txt.pointsize = 40
    }

    text.annotate(canvas, 0,0,-460,-330, "#{self.id} - #{self.lesson} - #{i} - #{self.romanji}") { |txt|
      txt.fill = '#000000'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 35
    }

    canvas.write("Todo/#{@@folder}/#{name}.png")
    # canvas.write("#{name}.png")
  end

  def set_kanji_note
    if kanji.present?
      kanjis = self.kanji.split(',')
      note = []
      kanjis.each do |kanji|
        note << fetch_romaji(kanji)
      end
      self.kanji_note = note.join(',') if self.kanji_note.blank?
    end
  end

  ROMAJI_URL = 'http://hvdic.thivien.net/whan/'
  def fetch_romaji name
    url = URI.encode "#{ROMAJI_URL}#{name}"

    page = Nokogiri::HTML(open(url))
    page.css('.hvres-definition.single .hvres-spell').last.try(:text).to_s.try(:squish)
  end

  def miss_word(name)
    name.gsub!('～', '')
    b_name = name.clone
    length = name.length
    positions = (1..length).to_a.sample((1..length).to_a.sample)
    positions.each do |position|
      b_name[position - 1] = '　'
    end
    b_name
  end

  def fetch_vn_mean
    url = URI.encode "http://mina.mazii.net/api/getSearchKotoba.php?query=#{self.romanji.strip}&start=0"
    response = Net::HTTP.get(URI(url))
    record = JSON.parse(response)["data"].detect{|n| n["roumaji"] == self.romanji.strip}
    if record.present?
      update(vn_mean: record["mean"], cn_mean: record["cn_mean"])
    end
  end

  #Step 1: find_by_char(a)
  #Step 2: find_by_char(a).find_dups -> Update vn_mean
  #Step 3: find_by_char.not_vn_mean.update(&:fetch_vn_mean_d)

  def fetch_vn_mean_d
    url = URI.encode "http://mazii.net/api/search/#{self.name}/10/1"
    response = Net::HTTP.get(URI(url))
    data = JSON.parse(response)["data"]
    record = data.detect{|n| n["word"] === self.name.strip}
    puts "#{self.name} #{self.id}"
    dash = "-"
    vn_mean = ""
    begin
      vn_mean = "#{dash}#{record["means"][0]["mean"]}"
    rescue
    end
    update(vn_mean: vn_mean)
  end

  def self.find_by_char(char)

    words = all.order(romanji: :asc).where('romanji LIKE ?', "#{char}%")
    puts "=========================== Have duplicate word  = #{words.find_dups.size} =============================="

    puts "=========================== Have word without VN MEAN = #{words.not_vn_mean.size} =============================="
    words.not_vn_mean.each do |w|
      p "#{w.id} #{w.name} #{w.romanji} #{w.mean}"
    end
    words
  end

  def self.find_dups
    words = []
    all.select(:id, :name, :mean, :vn_mean).group_by(&:name).each_value {|value| words << value if  value.size > 1 }
    words.each do |w|
      puts w.inspect
    end
    words
  end

  def ping_slack
    message = ":point_right:` #{self.name}`  |  `#{self.name_jp}`  |  `#{self.romanji}`  |  `#{self.mean}` |  `#{self.kanji_note}`"
    title = ":beauty:    #{self.name}"
    SlackNotifier.ping(
      channel: 'words',
      username: 'Review',
      attachments: [{
        color: '#00E676',
        pretext: "   #{self.mean} ",
        # title: title,
        mrkdwn: true,
        text: message,
        mrkdwn_in: ["text", "pretext"],
        footer: "#{self.id} - #{self.lesson}",
        footer_icon: ":beauty:",
        ts: Time.now.to_i
      }]
    )
  end

  def self.export_image_jisho folder = nil
    @@folder = folder
    if folder.blank?
      p "Please input name"
      return
    end
    folder = "#{Rails.root.to_s}/Todo/#{@@folder}"
    FileUtils::mkdir_p folder

    require 'RMagick'
    self.all.each_with_index do |word, index|
      word.fwrite_jisho(index + 1)
    end
    p "Todo/./ffmpeg -framerate 1/3 -i Todo/#{@@folder}/img%03d.png -s:v 1280x720 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p Todo/#{@@folder}/#{@@folder}.mp4"
    self.update_all(learned: true)
  end

  def fwrite_jisho i = 1
    n = i.to_s.rjust(3, "0")
    name = "img#{n}"

    granite = Magick::ImageList.new("#{Rails.public_path.to_s}/1280x720.png")
    canvas = Magick::ImageList.new
    canvas.new_image(1280, 720, Magick::TextureFill.new(granite))

    text = Magick::Draw.new
    text.font = "#{Rails.public_path.to_s}/fonts-japanese-gothic.ttf"
    note = self.kanji_note.to_s.split(",").join(" ") || ""

    text.annotate(canvas, 0,0,50,0, "#{self.lesson.to_s.remove("-")}") { |txt|
      txt.fill = '#000000'
      txt.gravity = Magick::NorthWestGravity
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 40
    }

    text.annotate(canvas, 0,0,0,80, "#{note.mb_chars.upcase.to_s}") { |txt|
      txt.fill = '#000000'
      txt.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
      txt.gravity = Magick::NorthGravity
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 30
    }

    text.gravity = Magick::CenterGravity

    text.annotate(canvas, 0,0,0,-80, "#{self.name}") { |txt|
      txt.fill = '#0000ff'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 120
    }


    text.annotate(canvas, 0,0,0,0, "#{self.romanji}") { |txt|
      txt.fill = '#000000'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 30
    }

    text.annotate(canvas, 0,0,0,50, "#{self.name_jp}") { |txt|
      txt.fill = '#E74C3C'
      txt.pointsize = 60
    }

    mean = breaking_word_wrap("#{self.vn_mean.present? ? self.vn_mean : self.mean}", 30)
    text.annotate(canvas, 0,0,0,175, "#{mean}\n#{self.cn_mean.to_s.mb_chars.upcase.to_s}") { |txt|
      txt.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
      txt.fill = '#555555'
      txt.pointsize = 40
    }

    # text.annotate(canvas, 0,0,-550,-330, "#{self.id} - #{i}") { |txt|
    #   txt.fill = '#000000'
    #   txt.font_weight = Magick::BoldWeight
    #   txt.pointsize = 35
    # }

    canvas.write("Todo/#{@@folder}/#{name}.png")
    # canvas.write("#{name}.png")
  end

  def self.remake_verbs
    self.all.each do |word|
      word.name_jp += word.name.chars.reject(&:kanji?).join(',').to_s
      word.romanji = word.name_jp.romaji
      word.save
    end
  end

end
