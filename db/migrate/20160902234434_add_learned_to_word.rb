class AddLearnedToWord < ActiveRecord::Migration
  def change
    add_column :words, :learned, :boolean, default: false
    add_column :words, :show, :boolean, default: false
    add_column :words, :vn_mean, :string, default: ''
  end
end
