class CreateDurations < ActiveRecord::Migration
  def change
    create_table :durations do |t|
      t.string :link
      t.string :name
      t.text :durations
      t.integer :vol_abulm_id
      t.integer :index_link
      t.integer :option

      t.timestamps null: false
    end
  end
end
