class VolAulmsController < ApplicationController
  protect_from_forgery :except => [:sync]
  layout 'simple'

  def index
    fols = Dir["public/audio/*"].select{|fol| File.directory?(fol) }.map{ |fol| File.split(fol)[1] }
    fols.each do |fol|
      VolAulm.create(name: fol) unless VolAulm.exists?(name: fol)
    end
    @vols = VolAulm.all
  end

  def show
    @vol = VolAulm.find(params[:id])
    audio = Rails.public_path.join('audio').to_s
    @files = Dir["#{audio}/#{@vol.name}/*.mp3"].map do |file|
      name = File.split(file)[1]
      { url: URI.encode("/audio/#{@vol.name}/#{name}"), name: name}
    end
  end

end
