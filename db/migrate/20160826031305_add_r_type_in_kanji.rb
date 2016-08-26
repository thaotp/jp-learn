class AddRTypeInKanji < ActiveRecord::Migration
  def change
    add_column :kanjis, :r_type, :string, default: ''
  end
end
