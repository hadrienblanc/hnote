module ApplicationHelper
  def markdown(text)
    return "" if text.blank?
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, safe_links_only: true)
    Redcarpet::Markdown.new(renderer,
      autolink: true, tables: true, fenced_code_blocks: true,
      strikethrough: true, superscript: true
    ).render(text).html_safe
  end
end
