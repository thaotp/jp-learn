namespace :scheduler do
  namespace :sentence do
    desc "This task is to ping to Slack Sentence"
    task :execute => :environment do
      execute_sentence
    end
  end

  namespace :radicals do
    desc "This task is to ping to Slack Radical"
    task :execute => :environment do

      # next if Delayed::Backend::ActiveRecord::Job.where(queue: 'radicals').present?
      execute_radical
    end
  end

  task :execute => :environment do
    execute_radical
    execute_sentence
  end

  def execute_radical
    second = Setting.find_by(name: 'RadicalTask').try(:value) || 5
    unless( (Time.now.midnight + 2.hours .. Time.now.midnight + 7.hours).cover? Time.now )
      radicals = Kanji.radicals.lastest
      radicals.each do |radical|
        radical.touch
        radical.delay(run_at: second.to_i.seconds.from_now, queue: 'radicals').ping_slack_radical
      end
    end
  end

  def execute_sentence
    return if Delayed::Backend::ActiveRecord::Job.where(queue: 'sentence').present?
    minute = Setting.find_by(name: 'SentenceTask').try(:value) || 20


    unless( (Time.now.midnight + 2.hours .. Time.now.midnight + 7.hours).cover? Time.now )
      sentences = Sentence.random_2
      sentences.each do |sentence|
        sentence.touch
        sentence.delay(run_at: minute.to_i.minutes.from_now, queue: 'sentence').ping_slack
      end
    end
  end
end
