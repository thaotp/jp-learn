require 'csv'
module ModelExtend
  extend ActiveSupport::Concern

  included do

  end

  class_methods do
    def excel
      file = CSV.open("#{Dir.pwd}/csv/excel-word#{Time.now.to_s}.csv", "w") do |csv|
        self.all.each do |i|
          i.hiragana = i.hiragana.gsub(/\s+/, '').gsub(',', '')
          i.created_at = ''
          csv << i.attributes.values_at(*[:sample, :hanviet, :mean, :hiragana].map(&:to_s))
        end
      end
    end
    def make_lesson(options = {})
      file = CSV.open("#{Dir.pwd}/csv/volmission-word#{Time.now.to_s}.csv", "w") do |csv|
        self.all.each do |i|
          i.hiragana = i.hiragana.gsub(/\s+/, '').gsub(',', '')
          i.created_at = ''
          csv << i.attributes.values_at(*[:hiragana, :mean, :hanviet, :sample, :hanviet, :type_w].map(&:to_s))
        end
      end
      file = CSV.open("#{Dir.pwd}/csv/volmission-kanji#{Time.now.to_s}.csv", "w") do |csv|
        self.all.each do |i|
          i.hiragana = i.hiragana.gsub(/\s+/, '').gsub(',', '')
          i.created_at = ''
          csv << i.attributes.values_at(*[:sample, :hiragana, :hanviet, :mean, :hanviet,:type_w].map(&:to_s))
        end
      end
    end
  end
end
