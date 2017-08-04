class AddExampleToMinaKotobas < ActiveRecord::Migration
  def change
    add_column :mina_kotobas, :example, :string
  end
end
