class MinaGrammar < ActiveRecord::Base
  def self.fetch
    (1..50).each do |i|
        url = "http://mina.mazii.net/api/getGrammar.php?lessonid=#{i}"
        response = Net::HTTP.get(URI(url))
        response = JSON.parse(response)
        response.each do |h|
          h.except!("favorite")
        end
        # p response
        self.create(response)
      end
  end

  require 'csv'
  def self.to_csv(options = {})
    (1..50).each do |i|
      file = CSV.open("#{Dir.pwd}/csv/grammar-mina-#{i}.csv", "w") do |csv|
        self.where(lesson_id: i).each do |word|
          word.content = Rails::Html::FullSanitizer.new.sanitize(word.content).gsub(/\$.*?\$/, '')
          attr_a = word.attributes
          csv << attr_a.values_at(*[:name, :content, :lesson_id].map(&:to_s))
        end
      end
    end
  end

  def self.all_csv(options = {})
    file = CSV.open("#{Dir.pwd}/csv/grammar-mina-all.csv", "w") do |csv|
      self.all.each do |word|
        word.content = Rails::Html::FullSanitizer.new.sanitize(word.content).gsub(/\$.*?\$/, '')
        attr_a = word.attributes
        csv << attr_a.values_at(*[:name, :content, :lesson_id].map(&:to_s))
      end
    end
  end


end
