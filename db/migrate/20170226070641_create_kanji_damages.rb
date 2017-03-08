class CreateKanjiDamages < ActiveRecord::Migration
  def change
    create_table :kanji_damages do |t|
      t.string :en_mean
      t.string :vn_mean
      t.string :hanviet
      t.string :kanji
      t.boolean :radical

      t.timestamps null: false
    end
  end
end
