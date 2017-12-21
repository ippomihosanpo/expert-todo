module ApplicationHelper
  def nl2br(str)
    if str.present?
      sanitize(str).gsub("\n", '<br>').html_safe
    end
  end
end
