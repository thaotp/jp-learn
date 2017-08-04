class KanjiB < ActiveRecord::Base
  include ModelExtend
  ActiveRecord::Base.establish_connection :kanji_b_japanse if Rails.env == "development"
  self.table_name = 'kanji_bs'
  belongs_to :kanji_damage, foreign_key: 'kanji', primary_key: 'kanji'
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

  def self.family_with(words: [])
    _s = ''
    samples = self.where(kanji: words).select(:id, :sample, :hanviet, :mean, :kanji).select do |word|
      (word.sample.chars - words).empty? && word.sample.chars.size > 1
    end
    count = 0
    ones = []
    others = []
    samples.group_by(&:kanji).each do |d|
      if d[1].size == 1
        ones << d
      else
        others << d
      end
    end
    # (words - samples.map(&:kanji)).each do |kanji|
    #   p self.where(kanji: kanji).sample
    # end
    (ones + others).each_with_index do |d, index|
      p "-----------------#{index}---#{d[0]}-----------------"
      d[1].each do |l|
        p l
      end
    end
    'Done .'
  end

  def self.clear_dup(ids: ids)
    words = self.where(id: ids)
    in_words = words.pluck(:sample)
    words = words.select(:id, :kanji, :sample, :hanviet).shuffle.select do |word|
      in_words.delete(word.sample)
      str = in_words.join('')
      first = word.sample.chars[0]
      last  = word.sample.chars[1]
      !(str.include?(first) && str.include?(last))
    end
    words.each do |o|
      p o
    end
    words.map(&:id)
  end

  def self.find_with(words: [])
    records = self.where(sample: (words.combination(2).to_a + words.reverse.combination(2).to_a).map(&:join))

    emptys = []
    exists = []
    results = []
    words.each do |word|
      next if exists.include?(word)
      childs = records.where(kanji: word).where.not(kanji: exists)
      if childs.empty?
        emptys << word
        next
      end
      child = childs.select do |wo|
        !(exists - wo.sample.chars).empty?
      end.sample
      child = childs.sample if child.blank?
      # exists << child.sample.chars.select do |wo|
      #   wo != word
      # end.join
      exists = (exists << child.sample.chars).flatten.uniq
      results << child
    end
    emptys = emptys.delete_if do |word|
      exists.include?(word)
    end
    p results.size
    p exists.size
    results.each do |word|
      p word
    end
    p emptys
    self.where(id: results.map(&:id))
  end

  def self.find_w(words: [])
    origins = words
    olds = KanjiC.where(level: [3,4,5]).pluck(:kanji)
    kol = KanjiB.where(kanji: olds).pluck(:sample)
    results = []
    records = where(sample: kol).where(kanji: origins)
    exists = []
    where(kanji: origins).group_by(&:kanji).each do |d|
      d[1].shuffle.each do |word|
        if (words & word.sample.chars).size == 2
          unless exists.include?(word.sample)
            exists << word.sample
            results << word
          end
          break
        end
      end
    end
    remains = records.where('"kanji_bs"."kanji" IN (?)', origins - results.map(&:sample).join('').split('').uniq)
    remains.group_by(&:kanji).each do |d|
      d[1].shuffle.each do |word|
        if word.sample.kanji? && word.sample.chars.size == 2
          results << word
          break
        end
      end
    end
    where(id: results.map(&:id))
  end

  def self.find_t(words: [])
    olds = KanjiC.where(level: [3,4,5]).pluck(:kanji) - words

    where(kanji: words).each do |ka|
      # (ka.sample.chars & words).size == 2
      p ka.sample
    end
  end

  def self.get_empty(words: [])
    results = []
    words.each do |word|
      search = KanjiB.where(kanji: word).select do |wo|
        if wo.sample.chars[0] == word
          wo.sample.chars[0] == word && wo.sample.chars.size == 2 && wo.hanviet.present?
        else
          wo.sample.chars.size == 2 && wo.hanviet.present?
        end
      end.sample
      p word if search.blank?
      results << search
    end
    results.map do |re|
      p re if re.try(:id).nil?
      re.try(:id)
    end
    # KanjiB.where(id: results).uniq
  end

  # For Kanji Learning
  def self.quizlet
    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil
    all.each do |w|
      w.hanviet = w.hanviet.mb_chars.upcase.to_s if w.hanviet.present?
      puts "#{w.sample};"
      puts "#{w.sample}"
      puts w.hanviet
      puts "#{w.mean}"
      w.sample.chars.each_with_index do |k, index|
        if index == 0
          puts "#{k}: #{KanjiC.where(kanji: k).pluck(:vn_mean).sample}"
        else
          puts "#{k}: #{KanjiC.where(kanji: k).pluck(:vn_mean).sample}+"
        end
      end
    end
    ActiveRecord::Base.logger = old_logger
    false
  end

  # For WordPerDay
  def self.quizlet_per_day
    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil
    all.each do |w|
      w.hanviet = w.hanviet.mb_chars.upcase.to_s if w.hanviet.present?
      mean_hanviet = []
      insert_hanviet = w.hanviet.blank?
      w.sample.chars.each_with_index do |k, index|
        next unless k.kanji?
        # if index == w.sample.chars.size - 1
        #   mean_hanviet << "#{k}: #{KanjiC.where(kanji: k).pluck(:vn_mean).sample}+"
        # else

        # end
        mean_hanviet << "#{k}: #{KanjiC.where(kanji: k).pluck(:vn_mean).sample}"
        if insert_hanviet
          w.hanviet = w.hanviet.to_s
          w.hanviet << KanjiC.where(kanji: k).pluck(:hanviet).sample.to_s
          w.hanviet = w.hanviet.mb_chars.upcase.to_s
        end
      end
      if mean_hanviet.blank?
        mean_hanviet << '+'
      else
        mean_hanviet[-1] = "#{mean_hanviet[-1].to_s}+"
      end
      w.save! if w.changed?
      puts "#{w.sample}^"
      puts "#{w.hiragana} (#{w.type_w})"
      puts w.hanviet if w.hanviet.present?
      puts "#{w.mean}"
      mean_hanviet.each do |k|
        puts k
      end
    end
    ActiveRecord::Base.logger = old_logger
    false
  end

  def self.select_uniq
    uniqs = []
    ids = self.all.map do |record|
      unless uniqs.include?(record.sample)
        uniqs << record.sample
        record.id
      end
    end.compact
    where(id: ids)
  end


  def update_hiragana!
    self.hiragana = Kakasi.kakasi('-JH -s', self.sample) if self.hiragana.blank?
    save!
  end

  def self.check_empty(words = [])
    words.each do |word|
      fetch(word) unless exists?(sample: word)
    end
  end

  def self.fetch(word)
    p word
    url = URI.encode "http://mazii.net/api/search/#{word}/20/1"
    response = Net::HTTP.get(URI(url))
    response = JSON.parse(response)
    results = { mean: response["data"][0]["means"][0]["mean"], sample: word, hiragana:  Kakasi.kakasi('-JH -s', word), type_w: response["data"][0]["means"][0]['kind'] }
    self.create(results)
  end
end
