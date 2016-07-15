class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name
      t.string :romanji
      t.string :mean
      t.string :name_jp
      t.integer :times

      t.timestamps null: false
    end
  end
end
