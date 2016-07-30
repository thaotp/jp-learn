class RandomsController < ApplicationController
  protect_from_forgery :except => [:sync]
  def index
    models = [Sentence]
    render json: models.sample.top_three.random.to_rep
  end

  def quiz
    render json: {words: Word.top_three.fetch_quiz.as_json, sentence: Sentence.random.as_json(:only => [:id, :content, :mean])}
  end

end