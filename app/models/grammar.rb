class Grammar < ActiveRecord::Base
  scope :random, -> { order(updated_at: :asc).limit(1).first }

  def to_rep
    self.touch
    {title: self.title || '', message: self.content || '', type: 'grammar'}
  end

  def self.import lesson, urls
    grammar = {lesson: lesson, urls: []}
    urls.each do |digest|
      grammar[:urls] << make_url(digest)
    end
    self.create! grammar
  end

  def self.make_url digest
    "https://i.gyazo.com/#{digest}.png"
  end
end
