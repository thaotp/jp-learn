class HomeController < ApplicationController
  def index

  end

  def public
    @times = params[:times] || ENV['TIMES']
  end
end
