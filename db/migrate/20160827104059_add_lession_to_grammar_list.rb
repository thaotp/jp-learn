class AddLessionToGrammarList < ActiveRecord::Migration
  def change
    add_column :grammar_lists, :lesson, :string
  end
end
