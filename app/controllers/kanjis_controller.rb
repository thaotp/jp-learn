class KanjisController < ApplicationController
  def index
    kanjis = Kanji.all.order(:id)
    render json: kanjis
  end

  def update
    kanji = Kanji.find(params[:kanji][:id])
    if kanji.update(permit_params)
      render json: {}, status: 200
    else
      render json: {}, status: 500
    end
  end

  def example
    @kanjis = KanjiC.make_to_learn
  end

  def n4words
    @words = JpltN4.order(romaji: :asc)
  end

  private

  def permit_params
    params.require(:kanji).permit(:times, :explain, :romaji)
  end
end
