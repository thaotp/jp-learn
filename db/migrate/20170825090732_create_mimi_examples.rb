class CreateMimiExamples < ActiveRecord::Migration
  def change
    create_table :mimi_examples do |t|
      t.string :title
      t.string :example
      t.string :mean
      t.string :position
      t.string :page
      t.references :mimi_kara_kotoba,                   foreign_key: true

      t.timestamps null: false
    end
  end
end
