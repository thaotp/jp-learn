class CreateGrammars < ActiveRecord::Migration
  def change
    create_table :grammars do |t|
      t.string :title
      t.string :content

      t.timestamps null: false
    end
  end
end
