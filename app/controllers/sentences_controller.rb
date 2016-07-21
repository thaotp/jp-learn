class SentencesController < ApplicationController
  protect_from_forgery :except => [:sync]
  def index
    sentence = Sentence.last || {}
    render json: sentence
  end

end