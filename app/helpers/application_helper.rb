module ApplicationHelper
  def full_title (title)
    origin = "Round App"
    if title.blank?
      return origin
    else
      return "#{origin}|#{title}"
    end
  end
end
