module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = "")
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def bootstrap_alert_class(type)
      case type.to_sym
      when :success then "success"
      when :error, :danger, :alert then "danger"
      when :notice, :info then "info"
      else type.to_s
      end
  end
end
