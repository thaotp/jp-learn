class AddStickToJpltN4s < ActiveRecord::Migration
  def change
    add_column :jplt_n4s, :stick, :boolean, default: false
  end
end
