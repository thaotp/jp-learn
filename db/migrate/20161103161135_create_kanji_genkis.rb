class CreateKanjiGenkis < ActiveRecord::Migration
  def change
    create_table :kanji_genkis do |t|
      t.string :name
      t.string :hiragana
      t.string :mean
      t.string :remember
      t.string :rkunjomi
      t.string :ronjomi
      t.string :kunjomi
      t.string :onjomi
      t.string :hanviet
      t.string :origin
      t.integer :kanji512_id
      t.string :lesson_id

      t.timestamps null: false
    end
  end
end
