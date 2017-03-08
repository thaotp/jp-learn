class MimiGrammar < ActiveRecord::Base
  def self.import_csv(url)
    require 'csv'
    data = []
    uri = URI(url)
    csv_text = Net::HTTP.get(uri)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>false)
    csv.each do |row|
      data << {title: row[0], use: row[1], mean: row[2], note: row[3]}
    end
    create!(data)
  end
end
