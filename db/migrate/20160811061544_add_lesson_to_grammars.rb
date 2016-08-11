class AddLessonToGrammars < ActiveRecord::Migration
  def change
    add_column :grammars, :lesson, :string, default: ''
  end
end
