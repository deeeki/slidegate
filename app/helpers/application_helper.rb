module ApplicationHelper
  def daily_link_on date
    link_to l(date), daily_path(year: '%04d' % date.year, month: '%02d' % date.month, day: '%02d' % date.day)
  end

  def bookmark_link slide
    link_to slide.bookmark_url, class: 'users' do
      raw "#{content_tag(:span, slide.bookmarks_count)}
      #{slide.bookmarks_count > 1 ? 'users' : 'user'}"
    end
  end
end
