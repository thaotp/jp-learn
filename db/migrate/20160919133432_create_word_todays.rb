class CreateWordTodays < ActiveRecord::Migration
  def change
    create_table :word_todays do |t|
      t.string :name
      t.string :romanji
      t.string :mean
      t.string :name_jp
      t.integer :lesson
      t.string :kanji
      t.string :kanji_note
      t.string :hint
      t.boolean :learned
      t.boolean :show
      t.string :vn_mean
      t.string :cn_mean
      t.boolean :hard
      t.string :today

      t.timestamps null: false
    end
  end
end
