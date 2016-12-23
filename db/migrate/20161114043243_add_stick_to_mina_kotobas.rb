class AddStickToMinaKotobas < ActiveRecord::Migration
  def change
    add_column :mina_kotobas, :stick, :boolean, default: false
  end
end
