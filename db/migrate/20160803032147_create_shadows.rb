class CreateShadows < ActiveRecord::Migration
  def change
    create_table :shadows do |t|
      t.string :question
      t.string :answer
      t.integer :session, default: 0
      t.string :question_romaji
      t.string :answer_romaji

      t.timestamps null: false
    end
  end
end
