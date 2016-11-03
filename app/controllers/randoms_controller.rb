class RandomsController < ApplicationController
  protect_from_forgery :except => [:slack]
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

  def minakotoba
    models = [MinaKotoba, MinaReibun]
    grammar_name = MinaGrammar.random.as_json(:only => [:id, :name, :lesson_id])
    words = models.sample.top_three.fetch_quiz
    render json: {words: words.as_json_as, sentence: grammar_name}
  end

  def read
    reader = Reader.newest
    reader.touch
    render json: reader
  end

  def slack
    position =  params[:current].to_i
    names =  params[:names].split(',')
    @word = eval(params[:content])[names[position]]
    @word[:name] = names[position]
    if params[:example].present?
      @example = eval(params[:example])
    end
    send_slack
    render json: {}
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

  private
  def send_slack
    message = @word.to_s
    message = ">  Hãy nhớ *#{@word[:meaning].upcase}* là  *#{@word[:name]}*"
    if @example.blank?
      title = "Hãy đọc nhanh thông tin bên dưới"
    else
      example_name = @example[:name]
      example_romaji = example_name.romaji[/\(.*?\)/]
      example_meaning = @example[:meaning]
      title = "Hãy nghe âm on và kun có trong từ #{example_name} \n #{example_name}#{example_romaji} có nghĩa là: #{example_meaning}"
    end
    SlackNotifier.ping(
      channel: 'teach',
      username: @word[:name],
      attachments: [{
        color: '#00E676',
        pretext: message,
        title: title,
        # title_link: url,
        mrkdwn: true,
        fields: [
            {
              title: "Có Onyomi là :",
              value: "#{@word[:onyomi]}(#{@word[:onyomi].romaji})",
              short: true
            },
            {
              title: "Có Kunyomi là :",
              value: "#{@word[:kunyomi]}(#{@word[:kunyomi].romaji})",
              short: true
            }
        ],
        mrkdwn_in: ["text", "pretext", "title", "fields"],
        footer_icon: ":beauty:",
        ts: Time.now.to_i
      }]
    )
  end

end
