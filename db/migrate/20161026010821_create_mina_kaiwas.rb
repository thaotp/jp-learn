class CreateMinaKaiwas < ActiveRecord::Migration
  def change
    create_table :mina_kaiwas do |t|
      t.string :c_roumaji
      t.string :character
      t.string :j_roumaji
      t.string :kaiwa
      t.string :lesson_id
      t.string :vi_mean

      t.timestamps null: false
    end
  end
end
