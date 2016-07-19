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

word_2= "これ これ this (thing here)
それ それ that (thing near you)
あれ あれ that (thing over there)
この～ この～ this ~, this ~ here
その～ その～ that ~, that ~ there
あの～ あの～ that ~, that ~ over there
本 ほん book
辞書 じしょ dictionary
雑誌 ざっし magazine
新聞 しんぶん newspaper
ノート ノート notebook
手帳 てちょう pocket notebook
名刺 めいし business card
カード カード card
テレホンカード テレホンカード telephone card
鉛筆 えんぴつ pencil
ボールペン ボールペン ballpoint pen
シャップペンシル シャップペンシル mechanical pencil
かぎ かぎ key
時計 とけい watch, clock
傘 かさ umbrella
かばん かばん bag, briefcase
テープ テープ (cassette) tape
テープレコーダー テープレコーダー tape recorder
テレビ テレビ television
ラジオ ラジオ radio
カメラ カメラ caera
コンピューター コンピューター computer
自動車 じどうしゃ automobile, car
机 つくえ desk
いす いす chair
チョコレート チョコレート chocolate
コーヒー コーヒー coffee
英語 えいご the English language
日本語 にほんご the Japanese language
～語 ～ご ~ language
何 なん what
そう そう so
違います ちがいます No it isn't, You are wrong
そうですか そうですか I see, Is that so?
あのう あのう well (used to show hesitation)
ほんの気持ちです ほんのきもちです It's nothing, It's a token of my gratitude
どうぞ どうぞ Please, Here you are (when offering someone something)
どうも どうも Well, thanks
ありがとう ありがとう Thank you
どうもありがとうございます どうもありがとございます Thank you very much
これからお世話になります これからおせわになります I hope for your kind assistance hereafter
こちらこそよろしく こちらこそよろしく I am pleased to meet you"

word_3 = "ここ ここ here, this place
そこそこ there, that place near you
あそこ あそこ that place over there
どこ どこ where, what place?
こちら こちら this way, this place (polite)
そちら そちら that way, that place near you (polite)
あちら あちら that way, that place over there (polite)
どちら どちら which way, where (polite)
教室 きょうしつ classroom
食堂 しょくどう dining hall, canteen
事務所 じむしょ office
会議室 かいぎしつ conference room, assembly room
受付 うけつけ reception desk
ロビー ロビー lobby
部屋 へや room
トイレ トイレ toilet, restroom
お手洗い おてあらい toilet, restroom
階段 かいだん staircase
エレベーター エレベーター elevator, lift
エスカレーター エスカレーター escalator
国 くに  country
会社 かいしゃ company
うち うち house, home
電話 でんわ telephone, telephone call
靴 くつ shoes
ネクタイ ネクタイ necktie
ワイン ワイン wine
たばこ たばこ tobacco, cigarette
売り場 うりば department, counter (in a department store)
地下 ちか basement
～階 ～かい  ~th floor
何階 なんがい what floor
～円 ～えん yen
いくら いくら how much
百 ひゃく hundred
千 せん thousand
万 まん ten thousand
すみません すみません Excuse me
～でございます ～でございます (polite form of 'desu')
～を見せてください ～をみせてください Please show me ~
じゃ じゃ well, then, in that case
～をください ～をください Give me ~, please. "

LESSON = 3
namespace :word do
  namespace :import do
    desc "This task is to import word."
    task :execute => :environment do
      words = []
      word_3.split("\n").each do |word_group|
        word_groups = word_group.split(" ")
        name = word_groups[0]
        name_jp = word_groups[1]
        mean = word_groups[2..-1].join(' ')
        words << {name: name, name_jp: name_jp, mean: mean, lesson: LESSON}
      end
      Word.create(words)
    end
  end
end
