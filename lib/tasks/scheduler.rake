namespace :scheduler do
  namespace :sentence do
    desc "This task is to ping to Slack"
    task :execute => :environment do
      unless( (Time.now.midnight + 2.hours .. Time.now.midnight + 7.hours).cover? Time.now )
        sentences = Sentence.random_2
        sentences.each do |sentence|
          sentence.touch
          sentence.delay(run_at: 20.minutes.from_now).ping_slack
        end
      end
    end
  end
end
