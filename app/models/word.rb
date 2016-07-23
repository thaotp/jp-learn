class Word < ActiveRecord::Base
  before_create :set_romanji, :set_kanji, :set_times
  validates_presence_of :name
  scope :random, -> { order("RANDOM()").limit(1).first }
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
    {title: self.try(:name) || '', message: self.try(:hint) || '', type: 'word'}
  end
end
