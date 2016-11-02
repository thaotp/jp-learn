class CreateMinaReibuns < ActiveRecord::Migration
  def change
    create_table :mina_reibuns do |t|
      t.integer :lesson_id
      t.string :reibun
      t.string :roumaji
      t.string :vi_mean
      t.integer :type

      t.timestamps null: false
    end
  end
end
