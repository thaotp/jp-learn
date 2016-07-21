class AddKanjiNoteToWords < ActiveRecord::Migration
  def change
    add_column :words, :kanji_note, :string
  end
end
