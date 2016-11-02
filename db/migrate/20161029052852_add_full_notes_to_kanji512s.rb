class AddFullNotesToKanji512s < ActiveRecord::Migration
  def change
    add_column :kanji512s, :full_notes, :text, array:true, default: []
  end
end
