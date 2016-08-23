class Sentence < ActiveRecord::Base
  scope :random, -> { order(updated_at: :asc).take(1)[0] }
  scope :random_2, -> { order(updated_at: :asc).take(2) }
  scope :top_three, -> { where(lesson: Sentence.uniq.pluck(:lesson).max(3)) }

  before_create :set_lesson

  def set_lesson
    self.lesson = 0 if self.lesson.blank?
  end

  def to_rep
    self.touch
    {title: self.content || '', message: self.mean || '', type: 'sentence'}
  end

  def self.bulk_import data
    sentences = []
    data.split("\n").each do |se|
      sentence = se.split(",")[0]
      lesson = se.split(",")[1]
      sentences << {content: sentence, lesson: lesson}
    end
    create! sentences
  end

  def ping_slack
    message = ":point_right:  `#{self.content}`"
    SlackNotifier.ping(
      username: 'Let\'s Speak',
      channel: 'aspeak-practise',
      attachments: [{
        color: '#00E676',
        # pretext: "#{self.mean}  #{'----' * 20}",
        # title: title,
        mrkdwn: true,
        text: message,
        mrkdwn_in: ["text", "pretext"],
        footer: "#{self.id} - #{self.lesson}",
        # footer_icon: ":beauty:",
        ts: Time.now.to_i
      }]
    )
  end

end
