class CreateMinaKotobas < ActiveRecord::Migration
  def change
    create_table :mina_kotobas do |t|
      t.string :cn_mean
      t.string :favorite
      t.string :hiragana
      t.string :kanji
      t.string :kanji_id
      t.string :lesson_id
      t.string :mean
      t.string :mean_unsigned
      t.string :roumaji
      t.string :tag

      t.timestamps null: false
    end
  end
end
