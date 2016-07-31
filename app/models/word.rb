require 'csv'
class Word < ActiveRecord::Base
  before_create :set_romanji, :set_kanji, :set_times
  validates_presence_of :name
  scope :top_three, -> { where(lesson: Word.uniq.pluck(:lesson).max(self.max_lesson)) }
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

  def self.max_lesson
    Setting.max_lesson.first.try(:value) || 3
  end

  def quiz_options
    (Word.where.not(id: self.id).pluck(:mean).sample(3) << self.mean).shuffle
  end

  def self.bulk_import(data, lesson)
    words = []
    data.split("\n").each do |word_group|
      word_groups = word_group.split(" ")
      name = word_groups[0]
      name_jp = word_groups[1]
      mean = word_groups[2..-1].join(' ')
      words << {name: name, name_jp: name_jp, mean: mean, lesson: lesson}
    end
    self.create(words)
  end

  def self.to_csv

    column_names = [:name_jp, :name, :mean]

    file = CSV.open("#{Dir.pwd}/csv/bai-#{self.first.try(:lesson)}.csv", "w") do |csv|
      all.each do |word|
        csv << word.attributes.values_at(*column_names.map(&:to_s))
      end
    end
    p "Done ..."
  end

end
