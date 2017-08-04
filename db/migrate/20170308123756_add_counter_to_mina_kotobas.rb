class AddCounterToMinaKotobas < ActiveRecord::Migration
  def change
    add_column :mina_kotobas, :counter, :integer, default: 0
  end
end
