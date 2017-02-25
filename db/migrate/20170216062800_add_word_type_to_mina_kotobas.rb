class AddWordTypeToMinaKotobas < ActiveRecord::Migration
  def change
    add_column :mina_kotobas, :word_type, :string
  end
end
