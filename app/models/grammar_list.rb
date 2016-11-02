require 'csv'
require 'open-uri'
class GrammarList < ActiveRecord::Base
  scope :lastest, -> { order(updated_at: :asc).limit(1) }
  has_many :grammar_examples
  def self.import_csv
    url = 'https://s3-us-west-2.amazonaws.com/jplearn/grammar/test.csv'
    uri = URI(url)
    csv_text = Net::HTTP.get(uri)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>false)
    csv.each do |row|
      puts row
    end
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
    p "Todo/./ffmpeg -framerate 1/5 -i Todo/#{@@folder}/img%03d.png -s:v 1280x720 -c:v libx264 -profile:v high -crf 20 -pix_fmt yuv420p Todo/#{@@folder}/#{@@folder}.mp4"
  end

  def fwrite i = 1
    granite = Magick::ImageList.new("#{Rails.public_path.to_s}/1280x720.png")
    canvas = Magick::ImageList.new
    canvas.new_image(1280, 720, Magick::TextureFill.new(granite))

    text = Magick::Draw.new
    text.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
    text.gravity = Magick::CenterGravity

    content = breaking_word_wrap(content1, 30)
    content.gsub!("`", "")
    content.gsub!("\"", "")

    text.annotate(canvas, 0,0,0,0, "#{self.lesson}- #{content}") { |txt|
      txt.gravity = Magick::NorthWestGravity
      txt.fill = '#ff2052'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 60
    }


    text.annotate(canvas, 0,0, 580,-320, "#{self.id} ") { |txt|
      txt.fill = '#000000'
      txt.gravity = Magick::CenterGravity
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 20
    }

    n = i.to_s.rjust(3, "0")
    name = "img#{n}"


    examples = self.grammar_examples
    content_ex = ""
    examples.each do |ex|
      ct = breaking_word_wrap("#{ex.name} #{ex.mean}", 49)
      content_ex += "#{ct}\n"

    end
    text.annotate(canvas, 0,0, 20,110, "#{content_ex} ") { |txt|
      txt.fill = '#000000'
      txt.gravity = Magick::WestGravity
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 35
    }

    canvas.write("Todo/#{@@folder}/#{name}.png")
    # canvas.write("#{name}.png")
  end

  def wrap(s, width=30)
    s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
  end

  def self.make_720
    require 'RMagick'
    files = Dir["/Users/THAO-NUS/Dropbox/Job/JapaneseLearning/Todo/grammar/*"]
    files.each do |file|
      extn = File.extname  file
      name = File.basename file, extn
      file_over = "#{Rails.public_path.to_s}/1280x720.png"
      # `composite #{file} #{file_over} -gravity center  Todo/grammar/append/#{name}.png`
    end
    files_a =  Dir["Todo/grammar/append/*"].sort_by{ |f| File.mtime(f) }

    files_a.each_with_index do |file, index|
      granite = Magick::ImageList.new(file)
      canvas = Magick::ImageList.new
      canvas.new_image(2560, 1440, Magick::TextureFill.new(granite))

      extn = File.extname  file
      name = File.basename file, extn

      text = Magick::Draw.new

      text.annotate(canvas, 0,0,0,0, "#{name}") { |txt|
        txt.gravity = Magick::NorthWestGravity
        txt.fill = '#ff2052'
        txt.font_weight = Magick::BoldWeight
        txt.pointsize = 60
        txt.font = "#{Rails.public_path.to_s}/fonts-japanese-gothic.ttf"
      }
      n = (index+1).to_s.rjust(3, "0")
      name_img = "img#{n}"
      canvas.write("Todo/grammar/finish/#{name_img}.png")
    end
  end



  def ping_slack
    message = "•    #{self.content2} \n •    #{self.content3}"
    title = "•    #{self.content2}"
    SlackNotifier.ping(
      channel: 'grammar',
      username: "Grammar #{self.lesson}",
      attachments: [{
        color: '#00E676',
        pretext: "   *#{self.content1}* ",
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
end
