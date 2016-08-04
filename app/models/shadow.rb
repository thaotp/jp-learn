class Shadow < ActiveRecord::Base
  before_create :translate

  def translate
    self.question_romaji = self.question.romaji
    self.answer_romaji = self.answer.romaji
  end

  def self.bulk_import(data, session)
    shadows = []
    data.split("\n").each do |word_group|
      word_groups = word_group.split(" ")
      question = word_groups[0]
      answer = word_groups[1]
      shadows << {question: question, answer: answer, session: session}
    end
    self.create(shadows)
  end
end
