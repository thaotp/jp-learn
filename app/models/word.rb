class Word < ActiveRecord::Base
  before_create :set_romanji, :set_kanji, :set_times
  validates_presence_of :name
  scope :top_three, -> { where(lesson: Word.uniq.pluck(:lesson).max(3)) }
  scope :random, -> { order(updated_at: :asc).limit(1).first }
  scope :fetch_quiz, -> { select(:id, :name, :name_jp, :mean).order(updated_at: :asc).limit(4) }
  def set_romanji
    self.romanji = self.name_jp.romaji
  end

  def set_kanji
    self.kanji = self.name.chars.select(&:kanji?)
  end

  def set_times
    self.times = 0
  end

  def to_rep
    self.touch
    {title: "#{self.try(:name)} (#{self.name_jp})" || '', message: self.try(:hint) || self.try(:mean), type: 'word'}
  end

  def as_json(options={})
    self.touch
    super(:methods => [:quiz_options]
    )
  end

  def quiz_options
    (Word.where.not(id: self.id).pluck(:mean).sample(3) << self.mean).shuffle
  end



end
