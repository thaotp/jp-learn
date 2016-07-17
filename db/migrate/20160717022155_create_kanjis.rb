class CreateKanjis < ActiveRecord::Migration
  def change
    create_table :kanjis do |t|
      t.string :name
      t.string :mean
      t.string :onyomi
      t.string :kunjomi
      t.string :romaji
      t.text :explain
      t.integer :times, default: 0
      t.text :vn_mean
      t.string :image
      t.string :radical
      t.string :stroke
      t.string :elements

      t.timestamps null: false
    end
  end
end
