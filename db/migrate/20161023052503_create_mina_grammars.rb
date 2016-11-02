class CreateMinaGrammars < ActiveRecord::Migration
  def change
    create_table :mina_grammars do |t|
      t.string :content
      t.integer :lesson_id
      t.string :name
      t.string :tag
      t.string :uname

      t.timestamps null: false
    end
  end
end
