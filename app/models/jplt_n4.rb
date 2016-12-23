require 'csv'
class JpltN4 < ActiveRecord::Base
  ActiveRecord::Base.establish_connection :kanji_b_japanse if Rails.env == "development"
  def self.import_csv(url)
    data = []
    csv_text = File.read(url)
    csv = CSV.parse(csv_text.gsub(/\r/, ''), :headers=>true)
    csv.each do |row|
      row_4 = ''
      if row[0].present?
        if row[0].kanji?
          search = row[0]
          kanji_sample = KanjiB.where("sample LIKE ?", "%#{search}%").first
        else
          search = row[0].chars.select(&:kanji?).join(',')
          kanji_sample = KanjiC.where("kanji LIKE ?", "%#{search}%").first
        end
      end

      row_4 = kanji_sample.hanviet if kanji_sample.present? && row[0].present?
      data << {kanji: row[0], hiragana: row[1], romaji: row[1].romaji, \
       en_mean: row[3], hanviet: row_4}
    end
    # p data
    create!(data)
  end

  def fetch_vn_mean
    p self.romaji
    url = URI.encode "http://mina.mazii.net/api/getSearchKotoba.php?query=#{self.romaji.try(:strip)}&start=0"
    response = Net::HTTP.get(URI(url))
    record = JSON.parse(response)["data"].detect{|n| n["roumaji"] == self.romaji.strip}
    if record.present?
      update(vn_mean: record["mean"], hanviet: record["cn_mean"])
    end
  end

  def self.to_csv(options = {})
    file = CSV.open("#{Dir.pwd}/words-n4#{Time.now}.csv", "w") do |csv|
      all.each do |word|
        col = word.vn_mean.present? ? :vn_mean : :en_mean
        csv << word.attributes.values_at(*[:kanji, :hiragana, col, :hanviet, :romaji].map(&:to_s))
      end
    end
  end

  scope :top_three, -> { limit(100).offset(0) }
  scope :fetch_quiz, -> { order(updated_at: :asc).limit(4) }
  def self.as_json_as(options={})
    transaction do
      all.map do |word|
        word.touch
        word.as_json(:methods => [:quiz_options, :question])
      end
    end
  end

  def question
    own = "#{self.hanviet.to_s.mb_chars.upcase.to_s} - #{self.kanji}(#{self.hiragana}): #{self.vn_mean.present? ? self.vn_mean : self.en_mean}"
  end

  def quiz_options
    options = JpltN4.where.not(id: self.id).sample(3).map do |word|
      [word.id, "#{word.hiragana} - #{word.vn_mean.present? ? word.vn_mean : word.en_mean}"]
    end
    q = "#{self.hiragana} - #{self.vn_mean.present? ? self.vn_mean : self.en_mean}"
    (options << [self.id, q]).shuffle
  end
end
