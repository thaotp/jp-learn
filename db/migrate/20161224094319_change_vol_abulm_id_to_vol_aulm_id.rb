class ChangeVolAbulmIdToVolAulmId < ActiveRecord::Migration
  def change
    rename_column :durations, :vol_abulm_id, :vol_aulm_id
  end
end
