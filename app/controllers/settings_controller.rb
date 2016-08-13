class SettingsController < ApplicationController
  protect_from_forgery :except => [:sync]
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

end
