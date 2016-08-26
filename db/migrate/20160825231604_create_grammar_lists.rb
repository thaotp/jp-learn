class CreateGrammarLists < ActiveRecord::Migration
  def change
    create_table :grammar_lists do |t|
      t.text :content1
      t.text :content2
      t.text :content3
      t.boolean  :show,       default: true
      t.timestamps null: false
    end
  end
end
