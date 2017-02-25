class Nichibei < ActiveRecord::Base
  has_many :nichibei_parts,  -> { order(:id, :stt) }
  accepts_nested_attributes_for :nichibei_parts, reject_if: proc { |attributes| attributes['body'].blank? }
  validates :body, :presence => true
  validates :lesson, :presence => true
  validates :dvd, :presence => true


  def replace
    sessions.times.map do |session|
      origin = body.dup
      n_parts = nichibei_parts.limit(parts).offset(session*parts)
      parts.times do |stt|
        origin.sub!('ーーー', n_parts[stt].body)
      end
      origin
    end
  end

  def self.quizlet
    nichibeis = []
    all.includes(:nichibei_parts).each do |nichibei|
      nichibeis << [ nichibei.replace ] + [nichibei.lesson]
    end
    nichibeis.each do |nichi|
      nichi[0].each do |ni|
        ni.split("\r\n").map.each_with_index do |para, index|
          content =  if index.even?
            'A:  '
          else
            'B : '
          end + para
          puts content
        end
        puts ';'
        puts nichi[1]
        puts '+'
      end
    end
    ''
  end
end
