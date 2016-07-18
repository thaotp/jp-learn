class Kanji < ActiveRecord::Base
  before_create :fetch_kanji
  validates_presence_of :name

  JP_URL = 'http://tangorin.com/kanji/'
  ROMAJI_URL = 'http://hvdic.thivien.net/word/'

  def fetch_kanji
    fetch_romaji
    fetch_jp
    self
  end

  def fetch_romaji
    url = URI.encode "#{ROMAJI_URL}#{self.name}"

    page = Nokogiri::HTML(open(url))
    self.romaji = page.css('.hvres-definition.single .hvres-spell').last.try(:text).to_s
    src = page.css('.hvres-header .hvres-animation img').last.try(:attr, 'src')

    if src.present?
      base64 = Base64.encode64(open("http://hvdic.thivien.net#{src}") {|f| f.read } ).gsub("\n", '')
      self.image = "data:image/gif;base64,#{base64}" if base64.present?
    end

    details = page.css('.hvres-details').last || ForceEmpty.new
    if details.css('.hvres-source').first.text() == "Từ điển phổ thông"
      self.vn_mean = details.css('.hvres-meaning').first.text()
    else
      details = page.css('.hvres-details').first || ForceEmpty.new
      if details.css('.hvres-source').first.text() == "Từ điển phổ thông"
        self.vn_mean = details.css('.hvres-meaning').first.text()
      end
    end
    self.vn_mean.gsub!("\n", ', ') if self.vn_mean.present?
  end

  def fetch_jp
    url = URI.encode "#{JP_URL}#{self.name}"
    page = Nokogiri::HTML(open(url))
    self.onyomi = page.css('.k-readings .kana').try(:text).to_s.split(' ').select(&:present?).select(&:contains_katakana?).join(', ')

    self.kunjomi = page.css('.k-readings .kana').try(:text).split(' ').select(&:contains_hiragana?).join(', ')
    self.mean = page.css('.k-lng-en').try(:text)
    self.example_tb = page.css('.k-compounds-table').try(:inner_html)

    infos = page.css('.k-info').first.try(:text).split(' ')

    if infos.present?
      radical_index = infos.index('Radical:')
      self.radical = infos[(radical_index + 1)..(radical_index + 2)].join(' ') if radical_index.present?
      stroke_index = infos.index('Strokes:')
      self.stroke = infos[stroke_index + 1] if stroke_index.present?
      element_index = infos.index('Elements:')
      self.elements = infos[element_index + 1] if element_index.present?
    end

  end





  class ForceEmpty
    def last
      self
    end

    def first
      self
    end

    def css params
      self
    end

    def text
      ''
    end
  end

end