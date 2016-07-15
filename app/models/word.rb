class Word < ActiveRecord::Base
  before_create :set_romanji, :set_kanji
  validates_presence_of :name
  def set_romanji
    self.romanji = self.name_jp.romaji
  end

  def set_kanji
    self.kanji = self.name.chars.select(&:kanji?)
  end
end
