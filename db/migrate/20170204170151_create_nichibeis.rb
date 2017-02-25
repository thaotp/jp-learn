class CreateNichibeis < ActiveRecord::Migration
  def change
    create_table :nichibeis do |t|
      t.string :lesson
      t.string :body
      t.string :dvd
      t.integer :sessions
      t.integer :parts

      t.timestamps null: false
    end
  end
end
