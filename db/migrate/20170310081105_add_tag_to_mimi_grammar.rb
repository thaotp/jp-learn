class AddTagToMimiGrammar < ActiveRecord::Migration
  def change
    add_column :mimi_grammars, :tag, :string, default: 'none'
  end
end
