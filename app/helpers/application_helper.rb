module ApplicationHelper
  def daily_link_on date
    link_to l(date), daily_path(year: '%04d' % date.year, month: '%02d' % date.month, day: '%02d' % date.day)
  end
end
