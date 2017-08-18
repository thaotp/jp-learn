class SettingsController < ApplicationController
  protect_from_forgery :except => [:sync]
  layout 'simple', only: :audio
  def update
    setting = Setting.max_lesson.first
    if setting.present?
      setting.update(value: params[:value].to_i)
    end
    render json: {}
  end

  def reader
    @readers = Reader.all.order(id: :asc)
  end

  def update
    reader_id = params[:reader_id]
    value = params["show_#{reader_id}".to_sym]
    Reader.find(reader_id).update(show: value)
    redirect_to reader_settings_path
  end

  def audio
    if params[:album].blank?
      fols = Dir["public/audio/*"].select{|fol| File.directory?(fol) }.map{ |fol| File.split(fol)[1] }
      fols.each do |fol|
        VolAulm.create(name: fol) unless VolAulm.exists?(name: fol)
      end
      @vols = VolAulm.all
      render 'album_blank'
    else
      @vol = VolAulm.find(params[:album])
      audio = Rails.public_path.join('audio').to_s
      @files = Dir["#{audio}/#{@vol.name}/*.mp3"].map do |file|
        name = File.split(file)[1]
        { url: URI.encode("/audio/#{@vol.name}/#{name}"), name: name}
      end
    end
  end

  def s_audio
    params[:duration] ||= []
    arr = params[:duration].each_cons(2).to_a
    path = Rails.public_path.join(URI.decode(params[:name])).to_s
    arr = arr.each_with_index.map do |mp3, index|
      range = Time.at(mp3[1].to_i - mp3[0].to_i).utc.strftime("%H:%M:%S")
      start_time = Time.at(mp3[0].to_i).utc.strftime("%H:%M:%S")
      "ffmpeg -i #{path} -acodec copy -ss #{start_time} -t #{range} #{++index}.mp3"
    end
    p arr
    render json: {}
  end

  def p_audio
    durations = params[:durations]
    durations.map!(&:to_i) if durations.present?
    audio = Duration.new(link: params[:link], durations: params[:durations], index_link: params[:index_link], option: params[:option], vol_aulm_id: params[:vol_aulm_id])
    audio.save
    # audio.execute if audio.save!
    render json: {}
  end
end
  protect_from_forgery :except => [:sync]
  layout 'simple', only: :audio
  def update
    setting = Setting.max_lesson.first
    if setting.present?
      setting.update(value: params[:value].to_i)
    end
    render json: {}
  end

  def reader
    @readers = Reader.all.order(id: :asc)
  end

  def update
    reader_id = params[:reader_id]
    value = params["show_#{reader_id}".to_sym]
    Reader.find(reader_id).update(show: value)
    redirect_to reader_settings_path
  end

  def audio
    if params[:album].blank?
      fols = Dir["public/audio/*"].select{|fol| File.directory?(fol) }.map{ |fol| File.split(fol)[1] }
      fols.each do |fol|
        VolAulm.create(name: fol) unless VolAulm.exists?(name: fol)
      end
      @vols = VolAulm.all
      render 'album_blank'
    else
      @vol = VolAulm.find(params[:album])
      audio = Rails.public_path.join('audio').to_s
      @files = Dir["#{audio}/#{@vol.name}/*.mp3"].map do |file|
        name = File.split(file)[1]
        { url: URI.encode("/audio/#{@vol.name}/#{name}"), name: name}
      end
    end
  end

  def s_audio
    params[:duration] ||= []
    arr = params[:duration].each_cons(2).to_a
    path = Rails.public_path.join(URI.decode(params[:name])).to_s
    arr = arr.each_with_index.map do |mp3, index|
      range = Time.at(mp3[1].to_i - mp3[0].to_i).utc.strftime("%H:%M:%S")
      start_time = Time.at(mp3[0].to_i).utc.strftime("%H:%M:%S")
      "ffmpeg -i #{path} -acodec copy -ss #{start_time} -t #{range} #{++index}.mp3"
    end
    p arr
    render json: {}
  end

  def p_audio
    durations = params[:durations]
    durations.map!(&:to_i) if durations.present?
    audio = Duration.new(link: params[:link], durations: params[:durations], index_link: params[:index_link], option: params[:option], vol_aulm_id: params[:vol_aulm_id])
    audio.save
    # audio.execute if audio.save!
    render json: {}
  end
end
    Reader.find(reader_id).update(show: value)
    redirect_to reader_settings_path
  end

  def audio
    if params[:album].blank?
      fols = Dir["public/audio/*"].select{|fol| File.directory?(fol) }.map{ |fol| File.split(fol)[1] }
      fols.each do |fol|
        VolAulm.create(name: fol) unless VolAulm.exists?(name: fol)
      end
      @vols = VolAulm.all
      render 'album_blank'
    else
      @vol = VolAulm.find(params[:album])
      audio = Rails.public_path.join('audio').to_s
      @files = Dir["#{audio}/#{@vol.name}/*.mp3"].map do |file|
        name = File.split(file)[1]
        { url: URI.encode("/audio/#{@vol.name}/#{name}"), name: name}
      end
    end
  end

  def s_audio
    params[:duration] ||= []
    arr = params[:duration].each_cons(2).to_a
    path = Rails.public_path.join(URI.decode(params[:name])).to_s
    arr = arr.each_with_index.map do |mp3, index|
      range = Time.at(mp3[1].to_i - mp3[0].to_i).utc.strftime("%H:%M:%S")
      start_time = Time.at(mp3[0].to_i).utc.strftime("%H:%M:%S")
      "ffmpeg -i #{path} -acodec copy -ss #{start_time} -t #{range} #{++index}.mp3"
    end
    p arr
    render json: {}
  end

  def p_audio
    durations = params[:durations]
    durations.map!(&:to_i) if durations.present?
    audio = Duration.new(link: params[:link], durations: params[:durations], index_link: params[:index_link], option: params[:option], vol_aulm_id: params[:vol_aulm_id])
    audio.save
    # audio.execute if audio.save!
    render json: {}
  end
end
