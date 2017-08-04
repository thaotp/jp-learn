class AddCounterToMimiKaraKotobas < ActiveRecord::Migration
  def change
    add_column :mimi_kara_kotobas, :counter, :integer, default: 0
  end
end
