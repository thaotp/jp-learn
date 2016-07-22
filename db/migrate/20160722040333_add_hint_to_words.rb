class AddHintToWords < ActiveRecord::Migration
  def change
    add_column :words, :hint, :string
  end
end
