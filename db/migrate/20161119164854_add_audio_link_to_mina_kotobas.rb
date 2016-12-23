class AddAudioLinkToMinaKotobas < ActiveRecord::Migration
  def change
    add_column :mina_kotobas, :audio_link, :string
  end
end
