class CreateRadicals < ActiveRecord::Migration
  def change
    create_table :radicals do |t|
      t.string :name
      t.string :mean
      t.integer :times, default: 0

      t.timestamps null: false
    end
  end
end
