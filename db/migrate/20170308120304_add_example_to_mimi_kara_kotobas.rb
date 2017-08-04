class AddExampleToMimiKaraKotobas < ActiveRecord::Migration
  def change
    add_column :mimi_kara_kotobas, :example, :string
  end
end
