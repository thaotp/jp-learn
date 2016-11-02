class CreateKanji512s < ActiveRecord::Migration
  def change
    create_table :kanji512s do |t|
      t.string :cn_mean
      t.string :favorite
      t.string :image
      t.string :kunjomi
      t.integer :lesson
      t.string :note
      t.string :numstroke
      t.string :onjomi
      t.string :remember
      t.string :rkunjomi
      t.string :ronjomi
      t.string :tag
      t.string :ucn_mean
      t.string :uvi_mean
      t.string :vi_mean
      t.string :word
      t.string :write
      t.timestamps false
    end
  end
end
