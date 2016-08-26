namespace :scheduler do
  namespace :sentence do
    desc "This task is to ping to Slack Sentence"
    task :execute => :environment do

      next if Delayed::Backend::ActiveRecord::Job.where(queue: 'sentence').present?

      unless( (Time.now.midnight + 2.hours .. Time.now.midnight + 7.hours).cover? Time.now )
        sentences = Sentence.random_2
        sentences.each do |sentence|
          sentence.touch
          sentence.delay(run_at: 20.minutes.from_now, queue: 'sentence').ping_slack
        end
      end
    end
  end

  namespace :radicals do
    desc "This task is to ping to Slack Radical"
    task :execute => :environment do

      # next if Delayed::Backend::ActiveRecord::Job.where(queue: 'radicals').present?

      unless( (Time.now.midnight + 2.hours .. Time.now.midnight + 7.hours).cover? Time.now )
        radicals = Kanji.radicals.lastest
        radicals.each do |radical|
          radical.touch
          radical.delay(run_at: 5.seconds.from_now, queue: 'radicals').ping_slack_radical
        end
      end
    end
  end
end
