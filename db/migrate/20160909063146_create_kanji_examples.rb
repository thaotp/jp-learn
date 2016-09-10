class CreateKanjiExamples < ActiveRecord::Migration
  def change
    create_table :kanji_examples do |t|
      t.string :name, default: ""
      t.string :name_jp, default: ""
      t.string :mean, default: ""

      t.timestamps null: false
    end
  end
end
