require 'csv'
class JpltN4Verb < ActiveRecord::Base
  def self.import_csv(url)
    data = []
    csv_text = File.read(url)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>false)
    csv.each do |row|
      vn_mean = ''
      row_4 = ''
      if row[0].present?
        if row[0].kanji?
          search = row[0]
          kanji_sample = KanjiB.where("sample LIKE ?", "%#{search}%").first
        else
          search = row[0].chars.select(&:kanji?).join(',')
          kanji_sample = KanjiC.where("kanji LIKE ?", "%#{search}%").first
        end

        vn_mean = KanjiB.where(sample: row[0]).first
        vn_mean = vn_mean.mean if vn_mean.present?
      end

      row_4 = kanji_sample.hanviet if kanji_sample.present? && row[0].present?

      data << {kanji: row[0], hiragana: row[1], romaji: row[1].romaji, \
       en_mean: row[3], hanviet: row_4, vn_mean: vn_mean}
    end
    # p data
    create!(data)
  end
end
