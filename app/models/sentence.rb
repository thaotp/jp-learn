class Sentence < ActiveRecord::Base
  scope :random, -> { order("RANDOM()").limit(1).first }

  def to_rep
    {title: self.content || '', message: self.mean || '', type: 'sentence'}
  end
end
