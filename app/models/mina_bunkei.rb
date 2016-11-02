class MinaBunkei < ActiveRecord::Base
  def self.fetch
    (1..50).each do |i|
      url = "http://mina.mazii.net/api/getBunkei.php?lessonid=#{i}"
      response = Net::HTTP.get(URI(url))
      response = JSON.parse(response)
      response.each do |h|
        h.except!("favorite")
      end
      # p response
      self.create(response)
    end
  end
end
