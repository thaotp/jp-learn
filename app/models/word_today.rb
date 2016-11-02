require 'csv'
class WordToday < ActiveRecord::Base
  def self.import_csv(url)
    data = []
    csv_text = File.read(url)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>false)
    csv.each do |row|
      data << {mean: row[0], name: row[1]}
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

    text.annotate(canvas, 0,0,0,-80, "#{self.name}") { |txt|
      txt.fill = '#ff033e'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 80
    }


    text.annotate(canvas, 0,0,0,55, "#{self.mean.to_s.mb_chars.upcase.to_s}") { |txt|
      txt.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
      txt.fill = '##36454f'
      txt.pointsize = 30
    }

    canvas.write("Todo/#{@@folder}/#{name}.png")
  end

end
