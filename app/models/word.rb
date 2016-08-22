require 'csv'
class Word < ActiveRecord::Base
  before_create :set_romanji, :set_kanji, :set_times
  validates_presence_of :name
  # Word.uniq.pluck(:lesson).max(self.max_lesson)
  scope :top_three, -> { where(lesson: self.max_lesson) }
  scope :random, -> { order(updated_at: :asc).limit(1).first }
  scope :fetch_quiz, -> { select(:id, :name, :name_jp, :mean, :kanji_note, :romanji, :kanji).order(updated_at: :asc).limit(4) }
  def set_romanji
    self.romanji = self.name_jp.romaji
  end

  def set_kanji
    self.kanji = self.name.chars.select(&:kanji?).join(',')
    set_kanji_note
  end

  def set_times
    self.times = 0
  end

  def to_rep
    self.touch
    {title: "#{self.try(:name)} (#{self.name_jp})" || '', message: self.try(:hint) || self.try(:mean), type: 'word'}
  end

  def self.as_json_as(options={})
    transaction do
      all.map do |word|
        word.touch
        word.as_json(:methods => [:quiz_options, :kanji_export])
      end
    end
  end

  def self.max_lesson
    Setting.max_lesson.first.try(:value) || 3
  end

  def quiz_options
    (Word.where.not(id: self.id).pluck(:name_jp).sample(3) << self.name_jp).shuffle
  end

  def kanji_export
    self.kanji.gsub(',','')
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
        word.name = '' if word.kanji.blank?
        csv << word.attributes.values_at(*column_names.map(&:to_s))
      end
    end
    p "Done ..."
  end

  def set_kanji_note
    if kanji.present?
      kanjis = self.kanji.split(',')
      note = []
      kanjis.each do |kanji|
        note << fetch_romaji(kanji)
      end
      self.kanji_note = note.join(',') if self.kanji_note.blank?
    end
  end

  ROMAJI_URL = 'http://hvdic.thivien.net/word/'
  def fetch_romaji name
    url = URI.encode "#{ROMAJI_URL}#{name}"

    page = Nokogiri::HTML(open(url))
    page.css('.hvres-definition.single .hvres-spell').last.try(:text).to_s.try(:squish)
  end

  def miss_word(name)
    name.gsub!('～', '')
    b_name = name.clone
    length = name.length
    positions = (1..length).to_a.sample((1..length).to_a.sample)
    positions.each do |position|
      b_name[position - 1] = '　'
    end
    b_name
  end

  def ping_slack
    message = ":point_right:` #{self.name}`  |  `#{self.name_jp}`  |  `#{self.romanji}`  |  `#{self.mean}`"
    title = ":beauty:    #{self.name}"
    SlackNotifier.ping(
      attachments: [{
        color: '#00E676',
        pretext: "#{self.mean}  #{'----' * 20}",
        # title: title,
        mrkdwn: true,
        text: message,
        mrkdwn_in: ["text", "pretext"],
        footer: "Slack API",
        footer_icon: ":beauty:",
        ts: Time.now.to_i
      }]
    )
  end

end
