require "csv"
require 'net/http'
namespace :grammar_list do
  desc "This class will read a csv file from url to GrammarList"

  task :read_csv, [:url] => :environment do |t, args|
    url = args[:url]
    uri = URI(url)
    csv_text = Net::HTTP.get(uri)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>false)
    csv.each do |row|
      index = GrammarList.where('grammar_lists.lesson LIKE ?', "#{row[0]}%").pluck(:lesson).uniq.count + 1
      lesson = "#{row[0]}.#{index}"
      grammar = GrammarList.new
      grammar.lesson = lesson
      grammar.content1 = row[1]
      grammar.content2 = row[2]
      grammar.content3 = row[3]
      grammar.save
    end
  end
end
