class GrammarsController < ApplicationController
  protect_from_forgery
  layout 'simple'
  def show
    @grammar = MinaGrammar.find(params[:id])
  end

  def learn
    @type = params[:type] || 'verb'
    @word = MinaKotoba.where(word_type: @type).sample
    respond_to do |format|
      format.html
      format.json {render json: @word}
    end
  end

end
