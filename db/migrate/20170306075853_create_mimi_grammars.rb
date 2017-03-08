class CreateMimiGrammars < ActiveRecord::Migration
  def change
    create_table :mimi_grammars do |t|
      t.string :title
      t.string :mean
      t.string :example
      t.string :use
      t.string :level
      t.string :note

      t.timestamps null: false
    end
  end
end
