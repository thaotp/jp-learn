class KanjiExample < ActiveRecord::Base
  before_create :set_romanji
  def self.bulk_import(data)
    words = []
    data.split("\n").each do |word_group|
      word_groups = word_group.split(" ")
      name = word_groups[0]
      name_jp = word_groups[1]
      mean = word_groups[2..-1].join(' ')
      words << {name: name, name_jp: name_jp, mean: mean}
    end
    create! words
  end

  def set_romanji
    self.romanji = self.name_jp.romaji
  end

  def self.detect_ids word
    ids = KanjiExample.where('name LIKE ?', "%#{word}%").pluck(:id)
    # ids.elements.slice_when {|i, j| i.to_i+1 != j.to_i }.to_a.flatten
    ids.slice_when {|i, j| i.to_i+1 != j.to_i }.to_a.sort{|x, y| y.length <=> x.length}.flatten
    # ids.slice_when {|i, j| i+1 != j }.to_a.max_by(&:length)
  end
end
