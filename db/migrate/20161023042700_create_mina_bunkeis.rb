class CreateMinaBunkeis < ActiveRecord::Migration
  def change
    create_table :mina_bunkeis do |t|
      t.string :bunkei
      t.integer :lesson_id
      t.string :roumaji
      t.string :vi_mean

      t.timestamps null: false
    end
  end
end
