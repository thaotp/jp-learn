class MinaKotoba < ActiveRecord::Base
  ActiveRecord::Base.establish_connection :kanji_b_japanse
  scope :top_three, -> { where(lesson_id: [26,27,28,29,30,31,32]) }
  scope :fetch_quiz, -> { order(updated_at: :asc).limit(4) }
  def self.fetch
    (1..50).each do |i|
      url = "http://mina.mazii.net/api/getKotoba.php?lessonid=#{i}"
      response = Net::HTTP.get(URI(url))
      response = JSON.parse(response)
      self.create(response)
    end
  end
  require 'csv'
  def self.to_csv(options = {})
    file = CSV.open("#{Dir.pwd}/mina-kotoba#{Time.now}.csv", "w") do |csv|
      all.each do |word|
        values = word.attributes
        values["question"] = word.kanji.present? ? "#{word.kanji}(#{word.hiragana}): #{word.mean}" : "#{word.hiragana}: #{word.mean}"
        values["anwser"] = word.kanji.present? ? "#{word.cn_mean}(#{word.roumaji}): #{word.mean}" : "#{word.roumaji}: #{word.mean}"
        csv << values.values_at(*[:question, :anwser, :kanji, :hiragana, :roumaji, :mean, :cn_mean, :lesson_id].map(&:to_s))
      end
    end
  end

  def self.as_json_as(options={})
    transaction do
      all.map do |word|
        word.touch
        word.as_json(:methods => [:quiz_options, :question, :answer])
      end
    end
  end

  def question
    own = self.kanji.present? ? "#{self.kanji}(#{self.hiragana}): #{self.mean}" : "#{self.hiragana}: #{self.mean}"
  end

  def answer
    self.kanji.present? ? "#{self.cn_mean}(#{self.roumaji}): #{self.mean}" : "#{self.roumaji}: #{self.mean}"
  end

  def quiz_options
    options = MinaKotoba.where.not(id: self.id).sample(3).map do |word|
      [word.id, word.kanji.present? ? "#{word.cn_mean}(#{word.roumaji}): #{word.mean}" : "#{word.roumaji}: #{word.mean}"]
    end
    q = self.kanji.present? ? "#{self.cn_mean}(#{self.roumaji}): #{self.mean}" : "#{self.roumaji}: #{self.mean}"
    (options << [self.id, q]).shuffle
  end
end
