class AddAudioUrlToReaders < ActiveRecord::Migration
  def change
    add_column :readers, :audio_url, :string, default: ''
  end
end
