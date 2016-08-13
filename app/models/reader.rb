class Reader < ActiveRecord::Base
  scope :newest, -> { where(show: true).order(updated_at: :asc).limit(1).first }

  def self.bulk_import(lesson = 1, amount = [0,0,0])
    link = 'https://s3-us-west-2.amazonaws.com/jplearn/SentenceRead'
    b = "b-#{lesson}"
    if(Reader.exists?(name: b))
      data = []
    else
      data = [{lesson: lesson, url: "#{link}/#{b}.png", name: b}]
    end

    r = amount.first
    u = amount[1]
    re = amount[2]
    (1..r).each do |el|
      r_el = "r-#{lesson}-#{el}"
      data << {lesson: lesson, url: "#{link}/#{r_el}.png", name: r_el}
    end
    (1..u).each do |el|
      u_el = "u-#{lesson}-#{el}"
      data << {lesson: lesson, url: "#{link}/#{u_el}.png", name: u_el}
    end

    (1..re).each do |el|
      re_el = "re-#{lesson}-#{el}"
      data << {lesson: lesson, url: "#{link}/#{re_el}.png", name: re_el}
    end

    create!(data)
  end

  def update_audio
    return false if self.name.include?("u")
    link = 'https://s3-us-west-2.amazonaws.com/jplearn/audio'
    name_audio = self.name.split('-')[0..1].join('_')
    self.audio_url = "#{link}/#{name_audio}.mp3"
    self.save
  end
end
