class SearchKotoba < ActiveRecord::Base
  include VideoMaker
  self.primary_key = :id
  self.inheritance_column = :__disabled__
  scope :top_three, -> { where(type: 'mimi_kara_kotoba').where(lesson_id: ['u1', 'u2', 'u3']) }
  scope :fetch_quiz, -> { order(updated_at: :asc).limit(4) }

  def self.as_json_as(options={})
    transaction do
      all.map do |word|
        word.touch
        word.as_json(:methods => [:quiz_options, :question, :answer])
      end
    end
  end

  def self.as_json_as(options={})
    transaction do
      all.map do |word|
        word.type.to_s.classify.safe_constantize.find(word.id).touch
        word.as_json(:methods => [:quiz_options, :question, :answer])
      end
    end
  end

  def question
    # own = self.kanji.present? ? "#{self.kanji}(#{self.hiragana}): #{self.mean}" : "#{self.hiragana}: #{self.mean}"
    # own = self.kanji.present? ? "#{self.kanji}(#{self.hiragana})" : "#{self.hiragana}"
    self.mean
  end

  def answer(word = self)
    # word.kanji.present? ? "#{word.cn_mean}(#{word.roumaji}): #{word.mean}" : "#{word.roumaji}: #{word.mean}"
    "#{word.kanji}(#{word.hiragana})"
  end

  def quiz_options
    options = SearchKotoba.where(type: 'mimi_kara_kotoba').where.not(id: self.id).sample(3).map do |word|
      [word.id, answer(word)]
      # [word.id, word.mean]
    end
    q = answer
    # q = "#{self.mean}"
    (options << [self.id, q]).shuffle
  end
end
