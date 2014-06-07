module ApplicationHelper
  def daily_link_on date, rel: nil
    label = l(date)
    label = raw("&larr; #{label}") if rel == :previous
    label = raw("#{label} &rarr;") if rel == :next
    link_to label, daily_path(year: '%04d' % date.year, month: '%02d' % date.month, day: '%02d' % date.day), rel: rel
  end

  def daily_pager_on date
    content_tag :ul, class: 'pager' do
      pager = content_tag(:li, daily_link_on(date - 1.day, rel: :previous), class: 'previous')
      pager << content_tag(:li, daily_link_on(date + 1.day, rel: :next), class: 'next') unless date == Date.today
      raw pager
    end
  end

  def bookmark_link slide
    link_to slide.bookmark_url, class: 'users' do
      raw "#{content_tag(:span, slide.bookmarks_count)}
      #{slide.bookmarks_count > 1 ? 'users' : 'user'}"
    end
  end
end
