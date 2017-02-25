class CreateNichibeiParts < ActiveRecord::Migration
  def change
    create_table :nichibei_parts do |t|
      t.integer :nichibei_id
      t.string :body
      t.integer :stt
      t.integer :session

      t.timestamps null: false
    end
  end
end
