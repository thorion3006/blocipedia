module ApplicationHelper
  def form_group_tag(errors, &block)
    css_Class = 'form-group'
    css_Class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_Class
  end

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      with_toc_data: true,
      prettify: true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
    }

    extensions = {
      no_intra_emphasis: true,
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      superscript: true,
      disable_indented_code_blocks: true,
      strikethrough: true,
      space_after_headers: true,
      highlight: true,
      quote: true,
      footnotes: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
