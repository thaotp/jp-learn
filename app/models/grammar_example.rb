class GrammarExample < ActiveRecord::Base
  belongs_to :grammar_list
  def self.import_csv(url)
    require 'csv'
    data = []
    csv_text = File.read(url)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>false)
    csv.each do |row|
      data << {name: row[0], mean: row[1], grammar_list_id: row[2]}
    end
    create!(data)
  end
end
