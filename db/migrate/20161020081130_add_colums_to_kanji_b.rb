class AddColumsToKanjiB < ActiveRecord::Migration
  def change
    add_column :kanji_bs, :kanji, :string, default: ''
    add_column :kanji_bs, :sample, :string, default: ''
    add_column :kanji_bs, :hiragana, :string, default: ''
    add_column :kanji_bs, :hanviet, :string, default: ''
    add_column :kanji_bs, :mean, :string, default: ''
    add_column :kanji_bs, :type_w, :string, default: ''
    add_column :kanji_bs, :romaji, :string, default: ''
  end
end
