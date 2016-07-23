class RandomsController < ApplicationController
  protect_from_forgery :except => [:sync]
  def index
    models = [Sentence, Word]
    render json: models.sample.random.to_rep
  end

end