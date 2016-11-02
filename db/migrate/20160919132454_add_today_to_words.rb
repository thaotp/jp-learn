class AddTodayToWords < ActiveRecord::Migration
  def change
    add_column :words, :today, :string
  end
end
