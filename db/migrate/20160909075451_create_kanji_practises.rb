class CreateKanjiPractises < ActiveRecord::Migration
  def change
    create_table :kanji_practises do |t|
      t.string :name, default: ""
      t.string :cn_name, default: ""
      t.text :elements, array: true, default: []

      t.timestamps null: false
    end
  end
end
