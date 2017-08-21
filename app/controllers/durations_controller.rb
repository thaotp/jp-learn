class DurationsController < ApplicationController
  protect_from_forgery :except => [:sync]
  layout 'simple'
  def show
    @vol = VolAulm.find(params[:vol_aulm_id])
    @duration = Duration.find(params[:id])
    audio = Rails.public_path.join('audio').to_s
    @files = Dir["#{audio}/#{@vol.name}/final/*#{@duration.name}"].map do |file|
      name = File.split(file)[1]
      { url: URI.encode("/audio/#{@vol.name}/final/#{name}"), name: name}
    end << { url: URI.encode("/audio/#{@vol.name}/#{@duration.name}"), name: "origin_#{@duration.name}"}
  end

  def edit
    @vol = VolAulm.find(params[:vol_aulm_id])
    @duration = Duration.find(params[:id])
    audio = Rails.public_path.join('audio').to_s
    @files = Dir["#{audio}/#{@vol.name}/final/*#{@duration.name}"].map do |file|
      name = File.split(file)[1]
      { url: URI.encode("/audio/#{@vol.name}/final/#{name}"), name: name}
    end << { url: URI.encode("/audio/#{@vol.name}/#{@duration.name}"), name: "origin_#{@duration.name}"}
  end

  def index
    @vol = VolAulm.find(params[:vol_aulm_id])
    @durations = @vol.durations
  end
end
