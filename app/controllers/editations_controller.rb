class EditationsController < ApplicationController
  layout 'simple'
  def index
    klass = params[:class].to_s.classify.safe_constantize
    
    if params[:id].present?
      @records = klass.where(id: params[:id])
    elsif  params[:lesson_id].present?
      @records = klass.where(lesson_id: params[:lesson_id])
    else
      @records = klass.all.last(1000)
    end
  end

  def update
    klass = params[:class].to_s.classify.safe_constantize
    klass.find(params[:id]).update("#{params[:attribute]}": params[:value])
    render json: {}, status: 200
  end
end
