require 'csv'
require 'open-uri'
class GrammarList < ActiveRecord::Base
  def self.import_csv
    url = 'https://s3-us-west-2.amazonaws.com/jplearn/grammar/test.csv'
    uri = URI(url)
    csv_text = Net::HTTP.get(uri)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>false)
    csv.each do |row|
      puts row
    end
  end

  def ping_slack
    message = "•    #{self.content2} \n •    #{self.content3}"
    title = "•    #{self.content2}"
    SlackNotifier.ping(
      channel: 'grammar',
      username: 'Grammar',
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
