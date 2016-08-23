namespace :scheduler do
  namespace :sentence do
    desc "This task is to ping to Slack"
    task :execute => :environment do
      sentences = Sentence.random_2
      sentences.each do |sentence|
        sentence.touch
        sentence.delay(run_at: 1.seconds.from_now).ping_slack
      end
    end
  end
end
