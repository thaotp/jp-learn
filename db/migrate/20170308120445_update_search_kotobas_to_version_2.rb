class UpdateSearchKotobasToVersion2 < ActiveRecord::Migration
  def change
    update_view :search_kotobas, version: 2, revert_to_version: 1
  end
end
