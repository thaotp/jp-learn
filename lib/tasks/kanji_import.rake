N5 = "日一国人年大十二本中長出三時行見月後前生五間上東四今金九入学高円子外八六下来気小七山話女北午百書先名川千水半男西電校語土木聞食車何南万毎白天母火右読友左休父雨"
namespace :kanji do
  namespace :import do
    desc "This task is to import kanji."
    task :execute => :environment do
      N5.chars.each do |kanji|
        Kanji.create!(name: kanji)
      end
    end
  end
end

JP_URL = 'http://tangorin.com/kanji/'
namespace :kanji do
  namespace :example do
    desc "This task is to create example kanji."
    task :execute => :environment do
      Kanji.all.select(:example_tb.blank?).each do |kanji|
        url = URI.encode "#{JP_URL}#{kanji.name}"
        page = Nokogiri::HTML(open(url))
        kanji.example_tb = page.css('.k-compounds-table').try(:inner_html)
        kanji.save
      end
    end
  end
end