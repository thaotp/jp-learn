class WordsController < ApplicationController
  protect_from_forgery :except => [:sync]
  def index
    @times = params[:times] || ENV['TIMES']
    lesson = Setting.type_lesson.first.try(:value) || 5
    words = Word.where(lesson: lesson).order(times: :asc)
    render json: words
  end

  def show
    @word = Word.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "file_name",
              layout: 'layouts/pdf.html.erb',
              formats: [:pdf],
              encoding: 'UTF-8',
              save_to_file: Rails.root.join('csv', "123.pdf"),
              header: {
                :center => '',
                :left => "",
                :right => ""
              },
              show_as_html: params.key?('debug')
      end
    end
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
      render json: {}, status: 201
    else
      render json: {}, status: 500
    end
  end

  def search
    key = params[:word]
    words = Word.where('romanji LIKE ?', "#{key}%")
    render json: words
  end

  def sync
    params[:words].each do |word|
      word_u = Word.find(word[:id])
      word_u.update(times: word[:times]) if word.present?
    end
    render json: Word.all, status: 200

  end

  private

  def permit_params
    params.require(:word).permit(:name, :name_jp, :mean, :lesson, :times, :kanji_note, :hint)
  end
end
