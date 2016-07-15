class AddChinaToRadicals < ActiveRecord::Migration
  def change
    add_column :radicals, :china, :string
  end
end
