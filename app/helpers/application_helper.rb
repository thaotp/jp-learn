module ApplicationHelper
  def paragraph(body)
    body.split("\r\n").map.each_with_index do |para, index|
      content_tag(:div, class: '') do
        content_tag(:span, "#{index.even? ? 'A:' : 'B:'}", class: 'object', style: 'margin-right: 10px; font-weight: bold;') +  if index.even?
          content_tag(:span, para)
        else
          content_tag(:span, para, style: 'color: blue;')
        end
      end
    end.join.html_safe
  end
end
