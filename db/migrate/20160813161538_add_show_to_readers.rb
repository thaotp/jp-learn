class AddShowToReaders < ActiveRecord::Migration
  def change
    add_column :readers, :show, :boolean, default: true
  end
end
