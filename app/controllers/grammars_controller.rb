class GrammarsController < ApplicationController
  protect_from_forgery

  def show
    @grammar = MinaGrammar.find(params[:id])
  end

end
