class MimiKaraKotoba < ActiveRecord::Base
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

  private
  def set_roumaji
    self.roumaji = self.hiragana.romaji
  end
  def set_hanviet
    hanviet = KanjiB.where(sample: kanji).last.try(:hanviet)
    self.cn_mean = hanviet if hanviet.present?
  end
end
