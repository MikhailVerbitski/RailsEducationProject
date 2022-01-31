module ApplicationHelper
  def markdown(text)
    Markdown.new(text, %i[hard_wrap autolink no_intra_emphasis]).to_html.html_safe
  end

  def markdown_without_link(text)
    html = markdown(text)
    doc = Nokogiri::HTML.fragment(html)
    doc.search('//a').remove
    doc.xpath("*").first(2).map(&:to_html).join.html_safe
  end

  def markdown_find_images(text)
    (text.scan(/data:[^"]+/) + text.scan(/(http[^"]+(png|jpg|"))/).flatten.map { |i| i.gsub('"', '') }).flatten
  end

  def current_theme
    current_user.theme || 'black'
  end
end
