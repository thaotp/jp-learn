class CreateKanjiCs < ActiveRecord::Migration
  def change
    create_table :kanji_cs do |t|
      t.string :kanji, default: ''
      t.string :hanviet, default: ''
      t.string :vn_mean, default: ''
      t.string :en_mean, default: ''
      t.string :jp_mean, default: ''
      t.integer :level

      t.timestamps null: false
    end
  end
end
