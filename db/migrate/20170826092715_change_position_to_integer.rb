class ChangePositionToInteger < ActiveRecord::Migration
  def change
    change_column :mimi_examples, :position, 'integer USING CAST(position AS integer)'
  end
end
