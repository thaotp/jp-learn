class CreateSearchKotobas < ActiveRecord::Migration
  def change
    create_view :search_kotobas
  end
end
