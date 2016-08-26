require "csv"
require 'net/http'
namespace :grammar_list do
  desc "This class will read a csv file from url to GrammarList"

  task :read_csv, :url do |t, args|
    url = args[:url]
    # url = 'https://s3-us-west-2.amazonaws.com/jplearn/grammar/test.csv'
    uri = URI(url)
    csv_text = Net::HTTP.get(uri)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>false)
    csv.each do |row|
      puts row
    end
  end
end
