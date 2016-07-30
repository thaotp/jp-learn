class Sentence < ActiveRecord::Base
  scope :random, -> { order(updated_at: :asc).limit(1).first }
  scope :top_three, -> { where(lesson: Sentence.uniq.pluck(:lesson).max(3)) }

  before_create :set_lesson

  def set_lesson
    self.lesson = 0 if self.lesson.blank?
  end

  def to_rep
    self.touch
    {title: self.content || '', message: self.mean || '', type: 'sentence'}
  end


end
