class AddRomanjiToKanjiExamples < ActiveRecord::Migration
  def change
    add_column :kanji_examples, :romanji, :string
  end
end
