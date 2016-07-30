class RandomsController < ApplicationController
  protect_from_forgery :except => [:sync]
  def index
    models = [Sentence, Word]
    render json: models.sample.random.to_rep
  end

  def quiz
    render json: {words: Word.fetch_quiz(params[:lesson]).as_json, sentence: Sentence.random.as_json(:only => [:id, :name, :mean])}
  end

end