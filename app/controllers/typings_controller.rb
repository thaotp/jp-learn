class TypingsController < ApplicationController
  protect_from_forgery
  layout 'simple'

  def index
  end

  def search
    render json: {}
  end

end
