module VideoMaker
  extend ActiveSupport::Concern
  included do
    def fwrite i = 1
      @@folder ||= nil
      folder = @@folder || 'Test'
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

      canvas.write("Todo/#{folder}/#{name}.png")
      # canvas.write("#{name}.png")
    end
  end
  class_methods do
    def export_image folder = nil
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
  end
end
