class UpdateSearchKotobasToVersion3 < ActiveRecord::Migration
  def change
    update_view :search_kotobas, version: 3, revert_to_version: 2
  end
end
