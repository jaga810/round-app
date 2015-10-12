module ApplicationHelper
  def full_title (title)
    origin = "Round App"
    if title.blank?
      return origin
    else
      return "#{origin}|#{title}"
    end
  end

  def needed_time(time)
    time.strftime("%D")
  end
end
