class AddExampleTbToKanjis < ActiveRecord::Migration
  def change
    add_column :kanjis, :example_tb, :text
  end
end
