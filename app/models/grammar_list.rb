require 'csv'
require 'open-uri'
class GrammarList < ActiveRecord::Base
  scope :lastest, -> { order(updated_at: :asc).limit(1) }
  def self.import_csv
    url = 'https://s3-us-west-2.amazonaws.com/jplearn/grammar/test.csv'
    uri = URI(url)
    csv_text = Net::HTTP.get(uri)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>false)
    csv.each do |row|
      puts row
    end
  end

  def self.export_image
    require 'RMagick'
    self.all.each_with_index do |word, index|
      word.fwrite(index + 1)
    end
  end

  def fwrite i = 1
    granite = Magick::ImageList.new("#{Rails.public_path.to_s}/1280x720.png")
    canvas = Magick::ImageList.new
    canvas.new_image(1280, 720, Magick::TextureFill.new(granite))

    text = Magick::Draw.new
    text.font = "#{Rails.public_path.to_s}/ARIALUNI.TTF"
    text.gravity = Magick::CenterGravity

    content = wrap(content1)

    text.annotate(canvas, 0,0,0,0, "#{content}") { |txt|
      txt.fill = '#000000'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 50
    }

    text.annotate(canvas, 0,0,-600,-320, "#{self.id}") { |txt|
      txt.fill = '#000000'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 20
    }

    text.annotate(canvas, 0,0, 600,-320, "#{self.lesson}") { |txt|
      txt.fill = '#000000'
      txt.font_weight = Magick::BoldWeight
      txt.pointsize = 20
    }

    n = i.to_s.rjust(3, "0")
    name = "img#{n}"
    canvas.write("/Users/THAO-NUS/Downloads/Todo/#{name}.png")
    # canvas.write("#{name}.png")
  end

  def wrap(s, width=30)
    s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
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
