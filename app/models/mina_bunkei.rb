class MinaBunkei < ActiveRecord::Base
  ActiveRecord::Base.establish_connection :kanji_b_japanse if Rails.env == "development"
  def self.fetch
    (1..50).each do |i|
      url = "http://mina.mazii.net/api/getBunkei.php?lessonid=#{i}"
      response = Net::HTTP.get(URI(url))
      response = JSON.parse(response)
      response.each do |h|
        h.except!("favorite")
      end
      # p response
      self.create(response)
    end
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
    "#{self.lesson_id}.#{self.bunkei} - #{self.vi_mean}"
  end

  def answer

  end

  def quiz_options
    options = MinaBunkei.where.not(id: self.id).sample(3).map do |word|
      [word.id, word.roumaji]
    end
    (options << [self.id, self.roumaji]).shuffle
  end
end
