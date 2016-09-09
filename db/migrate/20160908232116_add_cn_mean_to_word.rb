class AddCnMeanToWord < ActiveRecord::Migration
  def change
    add_column :words, :cn_mean, :string
  end
end
