class AddLevelToKanjis < ActiveRecord::Migration
  def change
    add_column :kanjis, :level, :string
  end
end
