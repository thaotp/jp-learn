class Reader < ActiveRecord::Base
  scope :newest, -> { order(updated_at: :asc).limit(1).first }

  def self.bulk_import(lesson = 1, amount = [0,0])
    link = 'https://s3-us-west-2.amazonaws.com/jplearn/SentenceRead'
    b = "b-#{lesson}"
    data = [{lesson: lesson, url: "#{link}/#{b}.png", name: b}]
    r = amount.first
    u = amount.last
    (1..r).each do |el|
      r_el = "r-#{lesson}-#{el}"
      data << {lesson: lesson, url: "#{link}/#{r_el}.png", name: r_el}
    end
    (1..u).each do |el|
      u_el = "u-#{lesson}-#{el}"
      data << {lesson: lesson, url: "#{link}/#{u_el}.png", name: u_el}
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
