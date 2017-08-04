class KanjiDamage < ActiveRecord::Base
  has_many :kanji_bs, foreign_key: 'kanji', primary_key: 'kanji'
  def update_radical radical
    if exists?(kanji: radical)
      update(radical: true)
    else
      p radical
    end
  end

  def refactor_record
    k = KanjiC.where(kanji: kanji).first
    if k.present?
      update(hanviet: k.hanviet, vn_mean: k.vn_mean, jp_mean: k.jp_mean)
    end
  end

  def self.find_nil
    where(radical: false).where(vn_mean: nil)
  end

  def sync_level
    self.level = KanjiC.where('kanji LIKE ?', "%#{self.kanji}%").last.try(:level)
    save!
  end
end
