class CreateVolAulms < ActiveRecord::Migration
  def change
    create_table :vol_aulms do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
