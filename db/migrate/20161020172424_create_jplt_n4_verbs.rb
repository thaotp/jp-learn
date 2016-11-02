class CreateJpltN4Verbs < ActiveRecord::Migration
  def change
    create_table :jplt_n4_verbs do |t|
      t.string :kanji, default: ''
      t.string :hiragana, default: ''
      t.string :en_mean, default: ''
      t.string :vn_mean, default: ''
      t.string :string, default: ''
      t.string :hanviet, default: ''

      t.timestamps null: false
    end
  end
end
