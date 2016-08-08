class CreateReaders < ActiveRecord::Migration
  def change
    create_table :readers do |t|
      t.string :lesson
      t.text :url
      t.string :name

      t.timestamps null: false
    end
  end
end
