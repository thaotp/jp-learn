class KanjiB < ActiveRecord::Base
  ActiveRecord::Base.establish_connection :kanji_b_japanse if Rails.env == "development"
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
end
