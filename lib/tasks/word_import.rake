word_1 = "わたし わたし I
わたしたち わたしたち we
あなた あんた you
あの人 あのひと that person, he, she
あの方 あのかた that person, he,she (more polite)
皆さん みなさん ladies and gentlemen, all of you
～さん ～さん Mr. Ms. (title of respect addded to a name)
～ちゃん ～ちゃん (suffix often added to a child's name)
～君 ～くん (suffix often added to a boy's name)
～人 ～じん (suffix meaning 'a national of')
先生 せんせい teacher, instructor (not used when referring to one's own job)
教師 きょうし teacher, instructor
学生 がくせい student
会社員 かいしゃいん company employee
社員 しゃいん employee of ~ company (used with a company name)
銀行員 ぎんこういん bank employee
医者 いしゃ medical doctor
研究者 けんきゅうしゃ researcher, scholar
エンジニア エンジニア engineer
大学 だいがく university
病院 びょういん hospital
電気 でんき electricity, light
だれ だれ who
どなた どなた who (polite)
～歳 ～さい ~years old
何歳 なんさい how old
おいくつ おいくつ how old (polite)
はい はい yes
いいえ いいえ no
失礼ですが しつれいですが Excuse me, but
お名前は おなまえは May I have your name?
初めまして はじめまして How do you do? (introducing oneself for the first time)
どうぞよろしく（お願いします） どうぞよろしく（おねがいします） Pleased to meet you
こちらは～さんです こちらは～さんです This is Mr. (Ms.) ~
～から来ました ～からきました I came (come) from ~"
namespace :word do
  namespace :import do
    desc "This task is to import word."
    task :execute => :environment do
      words = []
      word_1.split("\n").each do |word_group|
        word_groups = word_group.split(" ")
        name = word_groups[0]
        name_jp = word_groups[1]
        mean = word_groups[2..-1].join(' ')
        words << {name: name, name_jp: name_jp, mean: mean}
      end
      p words
      Word.create(words)
    end
  end
end
