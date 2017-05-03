module ApplicationHelper
  def form_group_tag(errors, &block)
    css_Class = 'form-group'
    css_Class << ' has-error' if errors.any?
    content_tag :div, capture(&block), class: css_Class
  end

  def active_class(link_path)
    current_page?(link_path) ? "active" : ""
  end

  def active_role(role)
    @user.role == role ? 'btn btn-default active' : 'btn btn-default'
  end
end
