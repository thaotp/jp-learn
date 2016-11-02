class KanjiC < ActiveRecord::Base
  ActiveRecord::Base.establish_connection :kanji_b_japanse
  self.table_name = 'kanji_cs'
  require 'csv'
  def self.import_csv(url)
    data = []
    csv_text = File.read(url)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>true)
    csv.each do |row|
      data << {kanji: row[0], hanviet: row[1], vn_mean: row[2], \
       en_mean: row[3], jp_mean: row[4], level: row[5]}
    end
    create!(data)
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

  end

  def fwrite i = 1
    n = i.to_s.rjust(3, "0")
    name = "img#{n}"

    granite = Magick::ImageList.new("#{Rails.public_path.to_s}/1280x720.png")
    canvas = Magick::ImageList.new
    canvas.new_image(1280, 720, Magick::TextureFill.new(granite))

    text = Magick::Draw.new
    text.font = "#{Rails.public_path.to_s}/fonts-japanese-gothic.ttf"

    # text.annotate(canvas, 0,0,0,80, "#{self.hanviet}") { |txt|
    #   txt.fill = '#000000'
    #   txt.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
    #   txt.gravity = Magick::NorthGravity
    #   txt.font_weight = Magick::BoldWeight
    #   txt.pointsize = 30
    # }

    text.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"

    text.gravity = Magick::CenterGravity

    text.annotate(canvas, 0,0,0,-80, "#{self.kanji}  #{self.hanviet}") { |txt|
      txt.fill = '#0000ff'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 120
    }


    text.annotate(canvas, 0,0,0,20, "#{self.vn_mean || self.en_mean}") { |txt|
      txt.fill = '#000000'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 60
    }

    text.annotate(canvas, 0,0,0,80, "#{self.jp_mean.try(:romaji)}") { |txt|
      txt.fill = '#000000'
      txt.pointsize = 40
    }

    text.annotate(canvas, 0,0,0,130, "#{self.jp_mean}") { |txt|
      txt.fill = '#E74C3C'
      txt.pointsize = 40
    }

    # mean = breaking_word_wrap("#{self.vn_mean.present? ? self.vn_mean : self.mean}", 30)
    # text.annotate(canvas, 0,0,0,175, "#{mean}\n#{self.cn_mean.to_s.mb_chars.upcase.to_s}") { |txt|
    #   txt.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
    #   txt.fill = '#555555'
    #   txt.pointsize = 40
    # }


    canvas.write("Todo/#{@@folder}/#{name}.png")
  end

  def self.make_to_learn
    words = where(level: [4,5]).order(kanji: :asc)
    contains = []
    words.each do |word|
      KanjiB.where(kanji: word.kanji).each do |b|
        contains << b if b.sample.contains_hiragana?
        contains << b if (words.pluck(:kanji) & b.sample.chars).length > 1
      end
    end
    KanjiB.where(id: contains.map(&:id)).order(kanji: :asc)
  end

end
