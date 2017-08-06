class DurationsController < ApplicationController
  protect_from_forgery :except => [:sync]
  layout 'simple'
  def show
    @vol = VolAulm.find(params[:vol_aulm_id])
    @duration = Duration.find(params[:id])
    audio = Rails.public_path.join('audio').to_s
    @files = Dir["#{audio}/#{@vol.name}/*.mp3"].map do |file|
      name = File.split(file)[1]
      { url: URI.encode("/audio/#{@vol.name}/#{name}"), name: name}
    end
  end

  def edit
    @vol = VolAulm.find(params[:vol_aulm_id])
    @duration = Duration.find(params[:id])
    audio = Rails.public_path.join('audio').to_s
    @files = Dir["#{audio}/#{@vol.name}/*.mp3"].map do |file|
      name = File.split(file)[1]
      { url: URI.encode("/audio/#{@vol.name}/#{name}"), name: name}
    end
  end
end
