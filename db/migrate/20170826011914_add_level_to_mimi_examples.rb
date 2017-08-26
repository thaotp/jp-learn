class AddLevelToMimiExamples < ActiveRecord::Migration
  def change
    add_column :mimi_examples, :level, :integer
  end
end
