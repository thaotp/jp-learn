class CreateGrammarExamples < ActiveRecord::Migration
  def change
    create_table :grammar_examples do |t|
      t.string :name
      t.string :mean
      t.integer :grammar_list_id

      t.timestamps null: false
    end
  end
end
