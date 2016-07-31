class SettingsController < ApplicationController
  protect_from_forgery :except => [:sync]
  def update
    setting = Setting.max_lesson.first
    if setting.present?
      setting.update(value: params[:value].to_i)
    end
    render json: {}
  end

end