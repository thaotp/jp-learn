class MimiExample < ActiveRecord::Base
  validates :title, presence: true
  #http://tuhoconline.net/tu-vung-n3-sach-mimi-kara-oboeru-67.html
  def self.fetch_tuhoconline_all
    1.upto(88) do |n|
      p "Start #{n}"
      fetch_tuhoconline n
    end
  end

  # page 1 Nội dung này được copy
  # page 3, 30 - 40 str[/(?<=\nTừ vựng N3 sách mimi kara oboeru #{number}\n)[\s\S]*(?=Những từ vựng)/]
  def self.fetch_tuhoconline number
    url = "http://tuhoconline.net/tu-vung-n3-sach-mimi-kara-oboeru-#{number}.html"
    page = Nokogiri::HTML(open(url))
    str = page.css('.entry-content')[0].text
    str = str[/(?<=\nTừ vựng N3 sách mimi kara oboeru #{number}\n)[\s\S]*(?=Những từ vựng)/]
    if str.blank?
      p "Can't #{number}"
      return
    end
    str.gsub! /(?<=\n\n)[\s\S]*(?="\";\r\n)/, ''
    process_ex str, number
  end

  def self.process_ex str, page
    first = str[/\d+(?=.)/].to_i
    str.split(/\d+[.](?=.)[\s|$]/).select(&:present?).map.each_with_index do |ex, index|
      save_example(ex, first + index, page)
    end
    # Tu tuong tu
    # Tu doi nghia
    # Tu ket hop
    # Tu lien quan
  end
  #MimiExample.where(example: MimiExample.find(1884).example).delete_all

  def self.save_example ex, position, page
    vidu = ex[/(?<=\nVí dụ :\n)[\s\S]*(?=\n)/]
    if vidu.blank?
      return
    end
    vidu = vidu.gsub /(?=Từ kết hợp :)[\s\S]*/, ''
    vidu = vidu.gsub /(?=Từ liên quan :)[\s\S]*/, ''
    vidu = vidu.gsub /(?=Từ tương tự :)[\s\S]*/, ''
    vidu = vidu.gsub /(?=Từ đối nghĩa :)[\s\S]*/, ''
    title = ex.split("\n")[0]

    vidu = vidu.split("\n").select(&:present?).map {|r| r.split(":")}.flatten.each_slice(2).to_a
    records = vidu.map do |re|
      {title:title, example: re[0], mean: re[1], position: position, page: page}
    end
    create! records
  end

end
