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
end
