class RandomsController < ApplicationController
  protect_from_forgery :except => [:sync]
  def index
    models = [Grammar]
    render json: models.sample.random.to_rep
  end

  def quiz
    words = Word.top_three.fetch_quiz
    words.each do |word|
      word.delay(run_at: 5.seconds.from_now).ping_slack
    end
    render json: {words: words.as_json_as, sentence: Sentence.random.as_json(:only => [:id, :content, :mean])}
  end

  def read
    reader = Reader.newest
    reader.touch
    render json: reader
  end

  def boost
    records = if params[:type] == 'grammar'
      Grammar.order(id: :desc)
    elsif params[:type] == 'kanji'
      []
    elsif params[:type] == 'shadow'
      Shadow.order(id: :asc)
    else
      Word.where(lesson: params[:lesson]).order(id: :asc)
    end

    render json: records
  end

end
