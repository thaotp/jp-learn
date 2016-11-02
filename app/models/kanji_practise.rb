class KanjiPractise < ActiveRecord::Base
  before_create :set_data
  def self.bulks_import data
    data.split(",").each do |w|
      create(name: w)
    end
  end
  # private
  def set_data
    self.elements = KanjiExample.detect_ids(self.name)
  end

  def reset_elements
    set_data
    save!
  end

  def self.export_image folder = nil
    @@folder = folder
    if folder.blank?
      p "Please input name"
      return
    end
    folder = "Todo/#{@@folder}"
    FileUtils::mkdir_p folder

    require 'RMagick'
    @@count = 1
    self.all.each_with_index do |word, index|
      word.fwrite(@@count)
    end
    "Todo/./ffmpeg -framerate 1/3 -i Todo/#{@@folder}/img%03d.png -s:v 1280x720 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p Todo/#{@@folder}/#{@@folder}.mp4"
  end

  def fwrite i = 1
    # n = i.to_s.rjust(3, "0")
    # name = "img#{n}"
    # granite = Magick::ImageList.new("#{Rails.public_path.to_s}/1280x720.png")
    # canvas = Magick::ImageList.new
    # canvas.new_image(1280, 720, Magick::TextureFill.new(granite))

    # text = Magick::Draw.new
    # text.font = "#{Rails.public_path.to_s}/fonts-japanese-gothic.ttf"
    # text.gravity = Magick::CenterGravity

    # text.annotate(canvas, 0,0,0,0, "#{self.name}") { |txt|
    #   txt.fill = '#000000'
    #   txt.font_weight = Magick::BoldWeight
    #   txt.pointsize = 500
    # }

    # text.annotate(canvas, 0,0,-480,-230, "#{self.cn_name}") { |txt|
    #   txt.fill = '#328422'
    #   txt.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
    #   txt.font_weight = Magick::BoldWeight
    #   txt.pointsize = 100
    # }

    # @@count += 1

    examples = KanjiExample.where(id: self.elements).select {|s| s.name.length < 3 }.take(10)
    make_examples examples
    # canvas.write("/Users/THAO-NUS/Downloads/Todo/#{name}.png")

    # canvas.write("#{folder}/#{name}.png")
  end

  def make_examples examples
    examples.each do |ex|
      n = @@count.to_s.rjust(3, "0")
      name = "img#{n}"
      @@count += 1
      granite = Magick::ImageList.new("#{Rails.public_path.to_s}/1280x720.png")
      canvas = Magick::ImageList.new
      canvas.new_image(1280, 720, Magick::TextureFill.new(granite))

      text = Magick::Draw.new
      text.font = "#{Rails.public_path.to_s}/fonts-japanese-gothic.ttf"
      text.gravity = Magick::CenterGravity
      text.annotate(canvas, 0,0,0,-20, "#{ex.name}") { |txt|
        txt.fill = '#000000'
        txt.font_weight = Magick::BoldWeight
        txt.pointsize = 220
      }
      text.annotate(canvas, 0,0,0,130, "#{ex.name_jp}") { |txt|
        txt.fill = '#E74C3C'
        txt.pointsize = 80
        txt.font_weight = Magick::BoldWeight
      }

      text.annotate(canvas, 0,0,0,205, "#{ex.mean} \n #{ex.romanji}") { |txt|
        txt.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
        txt.fill = '#555555'
        txt.pointsize = 40
      }

      text.annotate(canvas, 0,0,-480,-300, "#{self.cn_name}") { |txt|
        txt.fill = '#000000'
        txt.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
        txt.font_weight = Magick::BoldWeight
        txt.pointsize = 30
      }

      text.annotate(canvas, 0,0,-480,-230, "#{self.name}") { |txt|
        txt.fill = '#000000'
        txt.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
        txt.font_weight = Magick::BoldWeight
        txt.pointsize = 100
      }

      canvas.write("Todo/#{@@folder}/#{name}.png")
    end
  end
end
