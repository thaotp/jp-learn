class CreateMimiExampleKotobas < ActiveRecord::Migration
  def change
    create_table :mimi_example_kotobas do |t|
      t.string :example
      t.string :example_mean
      t.string :example_hiragana
      t.references :mimi_kara_kotoba,                   foreign_key: true

      t.timestamps null: false
    end
  end
end
