class AddLessonToWord < ActiveRecord::Migration
  def change
    add_column :words, :lesson, :integer, defaults: 0
  end
end
