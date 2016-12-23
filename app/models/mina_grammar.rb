class MinaGrammar < ActiveRecord::Base
  ActiveRecord::Base.establish_connection :kanji_b_japanse if Rails.env == "development"
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
  def self.random
    record = where(lesson_id: [26..50]).order(updated_at: :asc).limit(0).first
    record.touch
    record
  end

  LESSONS = (26..50).to_a
  scope :top_three, -> { where(lesson_id: LESSONS) }
  scope :fetch_quiz, -> { order(updated_at: :asc).limit(4) }

  def self.as_json_as(options={})
    transaction do
      all.map do |word|
        word.touch
        word.as_json(:methods => [:quiz_options, :question, :answer])
      end
    end
  end

  def question
    "#{self.lesson_id} - #{self.name}"
  end

  def answer

  end

  def quiz_options
    options = MinaGrammar.where.not(id: self.id).sample(3).map do |word|
      [word.id, word.name]
    end
    (options << [self.id, self.name]).shuffle
  end

end
