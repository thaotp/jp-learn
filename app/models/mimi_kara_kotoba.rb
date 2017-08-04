require 'rest-client'
require 'nokogiri'
class MimiKaraKotoba < ActiveRecord::Base
  has_many :mimi_example_kotobas
  before_create :set_roumaji, :set_hanviet
  def self.import(str, lesson)
    array = str.split(/(\d+)/).drop(1).reject{|e| e.to_i != 0}
    records = array.map.each_with_index do |e, index|
      arr = e.split(' ')
      e1 = arr[0]
      e2 = arr[1]
      e3 = arr[2..-1].join(' ')
      {stt: index+1, hiragana: e2, kanji: e1, mean: e3, lesson_id: lesson}
    end
    create!(records)
  end

  def self.to_csv

  end

  def check_hanviet
    if self.cn_mean.nil?
      self.cn_mean = self.kanji.chars.select(&:kanji?).map do |ka|
        res = KanjiC.where(kanji: ka)
        if res.present?
          res.first.hanviet.mb_chars.upcase.to_s if res.first.hanviet.present?
        else
          ''
        end
      end.join(' ')
      save!
    end
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

  def update_verb_to_masu
    words = ["起きる", "浴びる ", "借りる", "足りる", "出きる", "降りる", "落ちる", "過ぎる", "閉じる ", "出来る"]
    # p hiragana
    group = if hiragana.romaji[-3..-1] == 'eru' or words.include?(kanji)
      2
    else
      1
    end
    if group == 1
      a = hiragana.romaji.chars
      a[-1] = 'i'
      replace_word = a.join.hiragana.last
      self.hiragana[-1] = "#{replace_word}ます"
      self.kanji[-1] = "#{replace_word}ます"
    elsif group == 2
      new_w = kanji.chars
      new_w[-1] = 'ます'
      self.kanji = new_w.join
      new_w = hiragana.chars
      self.hiragana = new_w.join
    elsif group == 3

    else

    end
    self
  end

  def revert_verb
    kanji = self.kanji.romaji
    if(kanji.include?('emasu'))
      self.kanji = kanji.gsub('emasu', 'eru').hiragana
    else
      self.kanji = kanji.gsub('imasu', 'u').hiragana.gsub('しゅ', 'す')
    end
    save!
  end

  def get_example
    word = self.kanji || self.hiragana
    url = URI.encode "http://jisho.org/search/#{word}#sentences"
    pg = RestClient.get url
    doc = Nokogiri::HTML(pg.body)
    content = doc.css('.sentence_content').map do |el|
      {example: el.css('.unlinked').text, example_mean: el.css('.english').text}
    end

    content.each do |el|
      el[:example_hiragana] = Kakasi.kakasi('-JH -s', el[:example]) if el[:example].contains_kanji?
    end
    self.mimi_example_kotobas.create!(content)
    # w = doc.css('.ill-onebuttonplayer')
    # self.audio_link = w.attribute('data-url').value if w.present?
    # self.save
  end

  private
  def set_roumaji
    self.roumaji = self.hiragana.romaji
  end
  def set_hanviet
    hanviet = KanjiB.where(sample: kanji).last.try(:hanviet)
    self.cn_mean = hanviet if hanviet.present?
  end
end
