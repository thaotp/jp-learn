class AddJpMeanToKanjiDamages < ActiveRecord::Migration
  def change
    add_column :kanji_damages, :jp_mean, :string
  end
end
