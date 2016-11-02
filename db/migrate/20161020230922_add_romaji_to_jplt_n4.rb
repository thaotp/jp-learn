class AddRomajiToJpltN4 < ActiveRecord::Migration
  def change
    add_column :jplt_n4s, :romaji, :string, default: ''
  end
end
