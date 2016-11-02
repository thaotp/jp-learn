class CreateKanjiBs < ActiveRecord::Migration
  def change
    create_table :kanji_bs do |t|

      t.timestamps null: false
    end
  end
end
