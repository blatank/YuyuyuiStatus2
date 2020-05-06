module ApplicationHelper
  def full_title(title = '')
    app_name = "ゆゆゆいSSRステータス"
    if title.empty?
      app_name
    else
      "#{title} | #{app_name}"
    end
  end
end
