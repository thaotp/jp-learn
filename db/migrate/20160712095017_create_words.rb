class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :name
      t.string :romanji
      t.string :mean
      t.string :name_jp
      t.integer :times, default: 0

      t.timestamps null: false
    end
  end
end
