module ApplicationHelper
  def time_ago time, options = {}
    options[:class] ||= "timeago"
    content_tag(:abbr, time.in_time_zone(Time.zone).to_s, options.merge(:title => time.in_time_zone(Time.zone))) if time
  end
end
