class NichibeisController < ApplicationController
  layout 'simple'
  def index
    @nichibeis = Nichibei.all
  end

  def new
    @nichibei= Nichibei.new
    @parts_number = params[:parts]
    @sessions = params[:sessions]
  end

  def create
    @nichibei = Nichibei.create(nichibei_params)
    redirect_to new_nichibei_path(sessions: 5, parts: 0)
  end

  private

  def nichibei_params
    params.require(:nichibei).permit(:body, :lesson, :dvd, :parts, :sessions,
                                nichibei_parts_attributes: [ :stt, :body, :session ])
  end
end
