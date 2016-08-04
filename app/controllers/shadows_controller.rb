class ShadowsController < ApplicationController
  protect_from_forgery

  def index
    session = params[:session] || Setting.where(name: "ShadowSession").first.try(:value)
    @shadows = Shadow.where(session: session)
    render json: @shadows
  end

  def update
    render json: {}
  end

end