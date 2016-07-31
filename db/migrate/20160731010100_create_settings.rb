class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :value, default: 0
      t.string :name, default: ''

      t.timestamps null: false
    end
  end
end
