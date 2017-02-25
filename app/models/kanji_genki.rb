class KanjiGenki < ActiveRecord::Base
  ActiveRecord::Base.establish_connection :kanji_b_japanse if Rails.env == "development"
  scope :top_three, -> { where(lesson_id: LESSONS) }
  scope :fetch_quiz, -> { order(updated_at: :asc).limit(4) }
  LESSONS = '1'
  def self.as_json_as(options={})
    transaction do
      all.map do |word|
        word.touch
        word.as_json(:methods => [:quiz_options, :question, :answer])
      end
    end
  end

  def question
    own = "#{self.name}(#{self.hiragana}): #{self.mean}"
  end

  def answer
    "#{self.hanviet} (#{self.hiragana.romaji}): #{self.mean} - #{self.origin}"
  end

  def quiz_options
    options = KanjiGenki.where.not(id: self.id).sample(3).map do |word|
      [word.id, "#{word.hanviet} (#{word.hiragana.romaji}): #{word.mean}"]
    end
    q = "#{self.hanviet} (#{self.hiragana.romaji}): #{self.mean} - #{self.origin}"
    (options << [self.id, q]).shuffle
  end

  require 'csv'
  def self.to_csv_hanviet(options = {})
    file = CSV.open("#{Dir.pwd}/csv/kanji-genki#{Time.now}.csv", "w") do |csv|
      all.each do |word|
        word.hanviet = word.hanviet.mb_chars.upcase.to_s
        csv << word.attributes.values_at(*[:name,:hiragana , :mean, :hanviet, :lesson_id].map(&:to_s))
      end
    end
  end

  def self.quizlet
    all.each do |w|
      puts "#{w.hiragana};"
      puts w.name
      puts w.hanviet
      puts "#{w.mean}-"
    end
    false
  end
end

