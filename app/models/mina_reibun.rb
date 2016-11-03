class MinaReibun < ActiveRecord::Base
  ActiveRecord::Base.establish_connection :kanji_b_japanse if Rails.env == "development"
  def self.fetch
    (1..50).each do |i|
      url = "http://mina.mazii.net/api/getReibun.php?lessonid=#{i}"
      response = Net::HTTP.get(URI(url))
      response = JSON.parse(response)
      response.each do |h|
        h.except!("type")
      end
      # p response
      self.create(response)
    end
  end
  attr_accessor :col_reibun_roumaji
  attr_accessor :col_roumanji_vn_mean
  attr_accessor :col_reibun_vn_mean
  require 'csv'
  def self.to_csv(options = {})
    (1..50).each do |i|
      file = CSV.open("#{Dir.pwd}/csv/keibun-n4-#{i}.csv", "w") do |csv|
        self.where(lesson_id: i).each do |word|
          attr_a = word.attributes
          attr_a["col_reibun_roumaji"] = "#{word.reibun}\n#{word.roumaji}"
          attr_a["col_roumanji_vn_mean"] = "#{word.roumaji}\n#{word.vi_mean}"
          attr_a["col_reibun_vn_mean"] = "#{word.reibun}\n#{word.vi_mean}"
          p attr_a
          csv << attr_a.values_at(*[:reibun, :roumaji, :vi_mean, :col_reibun_roumaji, :col_reibun_vn_mean, :col_roumanji_vn_mean, :lesson_id].map(&:to_s))
        end
      end
    end
  end

  scope :top_three, -> { where(lesson_id: [26,27,28,29,30,31,32]) }
  scope :fetch_quiz, -> { order(updated_at: :asc).limit(4) }

  def self.as_json_as(options={})
    transaction do
      all.map do |word|
        word.touch
        word.as_json(:methods => [:quiz_options, :question, :answer])
      end
    end
  end

  def question
    "#{self.reibun} - #{self.vi_mean}"
  end

  def answer

  end

  def quiz_options
    options = MinaReibun.where.not(id: self.id).sample(3).map do |word|
      [word.id, word.roumaji]
    end
    (options << [self.id, self.roumaji]).shuffle
  end
end
