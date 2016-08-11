class AddUrlsToGrammars < ActiveRecord::Migration
  def change
    add_column :grammars, :urls, :text, array:true, default: []
  end
end
