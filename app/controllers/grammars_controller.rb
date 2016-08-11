class GrammarsController < ApplicationController
  protect_from_forgery

  def show
    grammar = Grammar.where(lesson: params[:lesson]).first
    grammar.touch
    render json: grammar
  end

end
