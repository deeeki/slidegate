module Hateb
  class Entry < OpenStruct
    class << self
      def new_from_element element
        anchor = element.at('a.entry-link')
        new({
          eid: element['data-eid'].to_i,
          bookmark_count: element['data-bookmark-count'].to_i,
          entryrank: element['data-entryrank'].to_i,
          title: anchor['title'],
          url: anchor['href'].gsub(/\?.*/, ''),
          bookmark_url: "http://b.hatena.ne.jp#{element.at('a[data-track-click-target="entry"]')['href']}",
          date: element.at('li.date').text,
        })
      end
    end
  end
end
