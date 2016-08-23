namespace :sheduler do
  namespace :sentence do
    desc "This task is to ping to Slack"
    task :execute => :environment do
      sentences = Sentence.random_2
      sentences.each do |sentence|
        sentence.ping_slack
      end
    end
  end
end
