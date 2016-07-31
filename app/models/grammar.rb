class Grammar < ActiveRecord::Base
  scope :random, -> { order(updated_at: :asc).limit(1).first }

  def to_rep
    self.touch
    {title: self.title || '', message: self.content || '', type: 'grammar'}
  end

  def self.bulk_import data
    records = data.split("\n")
    grammars = []
    records.each do |record|
      grammars << {title: record.split(",")[0], content: record.split(",")[1]}
    end
    self.create! grammars
  end
end
