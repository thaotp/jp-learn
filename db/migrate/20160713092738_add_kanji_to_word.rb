class AddKanjiToWord < ActiveRecord::Migration
  def change
    add_column :words, :kanji, :string
  end
end
