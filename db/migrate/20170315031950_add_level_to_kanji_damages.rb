class AddLevelToKanjiDamages < ActiveRecord::Migration
  def change
    add_column :kanji_damages, :level, :integer
  end
end
