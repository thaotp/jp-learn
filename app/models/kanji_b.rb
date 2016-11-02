class KanjiB < ActiveRecord::Base
  ActiveRecord::Base.establish_connection :kanji_b_japanse
  self.table_name = 'kanji_bs'
  def self.raw_hiragana
    KanjiC.where(level: [4, 5]).pluck(:kanji).each do |kn|
      KanjiB.where(kanji: kn).where(romaji: "").each do |kan|
        url = URI.encode "http://tangorin.com/general/#{kan.sample}"
        p kan.sample
        p kan.id
        page = Nokogiri::HTML(open(url))
        # hiragana =  page.css("#dictEntries.results .entry")[0].css("dt span.kana rb").text
        if kan.hiragana.blank? && !page.nil?
          if page.css("#dictEntries.results .entry")[0].present?
            romaji = page.css("#dictEntries.results .entry")[0].css("dt span.kana rt").text
            hiragana = romaji.hiragana
            kan.update({romaji: romaji, hiragana: hiragana})
          end
        end
      end
    end

  end
  require 'csv'
  def self.import_csv(url)
    data = []
    csv_text = File.read(url)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>true)
    csv.each do |row|
      data << {kanji: row[1], sample: row[2], hanviet: row[4], \
       mean: row[5], type_w: row[6]}
    end
    create!(data)
  end
end
