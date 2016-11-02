class AddRomanjiToJpltN4Verb < ActiveRecord::Migration
  def change
    add_column :jplt_n4_verbs, :romaji, :string, default: ''
  end
end
