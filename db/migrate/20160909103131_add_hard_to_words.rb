class AddHardToWords < ActiveRecord::Migration
  def change
    add_column :words, :hard, :boolean, default: false
  end
end
