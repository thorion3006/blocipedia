module ApplicationHelper
  def form_group_tag(errors, &block)
    css_Class = 'form-group'
    css_Class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_Class
  end
end
