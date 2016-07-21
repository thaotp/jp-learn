class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string :content
      t.string :hiragana
      t.string :mean
      t.string :lesson

      t.timestamps null: false
    end
  end
end
