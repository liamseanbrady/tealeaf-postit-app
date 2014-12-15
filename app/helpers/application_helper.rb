module ApplicationHelper

def fix_url(str)
  str.starts_with?('http://') ? str : "http://#{str}"
end

def display_datetime(dt)
  dt = dt.in_time_zone(current_user.time_zone) if logged_in? && !current_user.time_zone.blank?
  dt.strftime("%m/%d/%Y %l:%m%P %Z")
end

end
