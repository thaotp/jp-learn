class WordsController < ApplicationController
  protect_from_forgery :except => [:sync]
  def index
    if params[:mobile].present?
      words = Word.where(show: true).where.not(learned: true).order(updated_at: :asc)
    else
       @times = params[:times] || ENV['TIMES']
       lesson = Setting.type_lesson.first.try(:value) || 5
       words = Word.where(lesson: lesson).order(id: :asc)
    end

    render json: words
  end

  def show
    @words = Word.where(lesson: params[:lesson]).select do |word|
      word.name_jp.length < 9
    end

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "lesson_#{params[:lesson]}",
              layout: 'layouts/pdf.html.erb',
              orientation: 'Landscape',
              formats: [:pdf],
              encoding: 'UTF-8',
              viewport_size: '1280x1024',
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
    id = key.to_i
    id = -1 if id == 0
    words = MinaKotoba.where('id = ? OR hiragana LIKE ? OR kanji LIKE ? OR mean LIKE ? OR roumaji LIKE ?', "#{id}", "%#{key}%", "%#{key}%", "%#{key}%", "%#{key}%")
    render json: words
  end

  def lesson
    lesson = params[:lesson]
    words = Word.where(lesson: lesson).order(id: :asc)
    render json: words
  end

  def sync
    params[:words].each do |word|
      word_u = Word.find(word[:id])
      word_u.update(times: word[:times]) if word.present?
    end
    render json: Word.all, status: 200

  end


  def type

  end

  private

  def permit_params
    params.require(:word).permit(:name, :name_jp, :mean, :lesson, :times, :kanji_note, :hint)
  end

  def cof_setting(text)
    cof = {}
    if (0..4).include? text.length
      cof[:row] = 2
      cof[:loop] = 6
    elsif (5..6).include? text.length
      cof[:row] = 3
      cof[:loop] = 4
    else
      cof[:row] = 3
      cof[:loop] = 3
    end
    cof
  end

end
