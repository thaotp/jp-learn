class Kanji512 < ActiveRecord::Base
  ActiveRecord::Base.establish_connection :development if Rails.env == "development"
  def self.fetch
    (1..32).each do |i|
      url = "http://mina.mazii.net/api/getIKanji.php?lessonid=#{i}"
      response = Net::HTTP.get(URI(url))
      response = JSON.parse(response)
      # p response
      self.create(response)
    end
  end

  def notes
    note.split('※').reject(&:blank?).map do |nt|
      nt.split('∴')
    end
  end

  def set_hanviet
    news = notes.map do |n|
      n << n.first.chars.select(&:kanji?).map do |k|
        KanjiC.where(kanji: k).pluck(:hanviet)
      end.join(' ')
    end
  end

  def self.to_csv(options = {})
    file = CSV.open("#{Dir.pwd}/csv/kanji-512#{Time.now}.csv", "w") do |csv|
      all.each do |word|
        hWord = word.attributes
        hWord['remember'] = Rails::Html::FullSanitizer.new.sanitize(word.remember)
        hWord['on_kun'] = "#{word.kunjomi}, #{word.onjomi}"
        hWord['anwser'] = "#{word.word}(#{word.cn_mean}) - #{hWord['on_kun'].romaji}"
        csv << hWord.values_at(*[:anwser, :on_kun, :word, :vi_mean, :cn_mean, :remember, :lesson].map(&:to_s))
      end
    end
  end

  def self.to_csv_ex(options = {})
    file = CSV.open("#{Dir.pwd}/csv/kanji-512#{Time.now}.csv", "w") do |csv|
      all.each do |word|
        hWord = {}
        word.set_hanviet.each do |h|
          hWord[:kanji] = h[0]
          hWord[:hiragana] = h[1]
          hWord[:mean] = h[2]
          hWord[:hanviet] = h[3]
          hWord[:on_kun] = "#{word.kunjomi}, #{word.onjomi}"
          hWord[:remember] = Rails::Html::FullSanitizer.new.sanitize(word.remember)
          csv << hWord.values_at(*[:kanji, :hiragana, :mean, :hanviet, :on_kun, :remember])
        end
      end
    end
  end
end
