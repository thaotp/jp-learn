class WordsController < ApplicationController
  def index
    p 'otsukaresamadesu'
    p 'おつかれさまです'
    words = Word.all
    render json: words
  end

  def create
    if Word.create!(permit_params)
      render json: {}, status: 201
    else
      render json: {}, status: 500
    end
  end

  def update
    word = Word.find(params[:word][:id])
    if word.update(permit_params)
      render json: {}, status: 200
    else
      render json: {}, status: 500
    end
  end

  private

  def permit_params
    params.require(:word).permit(:name, :name_jp, :mean, :lesson, :times)
  end
end
