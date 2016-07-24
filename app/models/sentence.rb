class Sentence < ActiveRecord::Base
  scope :random, -> { order(updated_at: :asc).limit(1).first }

  def to_rep
    self.touch
    {title: self.content || '', message: self.mean || '', type: 'sentence'}
  end
end
