module Hateb
  class Entry < OpenStruct
    class << self
      def new_from_element element
        anchor = element.at('a.entry-link')
        new({
          eid: element['data-eid'].to_i,
          bookmark_count: element.at('li.users a span').text.to_i,
          entryrank: anchor['data-entryrank'].to_i,
          title: anchor['title'],
          url: anchor['href'].gsub(/\?.*/, ''),
          bookmark_url: "http://b.hatena.ne.jp#{element.at('a[data-track-click-target="entry"]')['href']}",
          date: Time.parse(element.at('li.date').text),
        })
      end
    end
  end
end
