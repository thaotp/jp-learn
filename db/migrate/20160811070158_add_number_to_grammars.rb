class AddNumberToGrammars < ActiveRecord::Migration
  def change
    add_column :grammars, :number, :integer, default: 0
  end
end
