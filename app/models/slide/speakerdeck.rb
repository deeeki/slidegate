class Slide::Speakerdeck < Slide
  class << self
    def agent
      @agent ||= Mechanize.new
    end

    def valid_url? url
      url =~ /speakerdeck.com\/(u\/)?[^\/]{2,}\/(p\/)?[^\/]+$/ && url !~ /speakerdeck.com\/embed\//
    end

    def new_from_entry entry
      new({
        eid: entry.eid,
        title: entry.title,
        url: entry.url,
        bookmark_url: entry.bookmark_url,
        bookmarked_at: entry.date,
        bookmarks_count: entry.bookmark_count,
      })
    end
  end

  def fetch
    return unless url
    page = self.class.agent.get(url)
    assign_attributes({
      title: page.at('#talk-details h1').text.strip,
      download_url: page.at('a#share_pdf')['href'],
      author_name: page.at('#talk-details h2 a').text.strip,
      published_at: Date.parse(page.at('#talk-details mark:first-child').text.strip).to_time,
      category: page.at('#talk-details mark:last-child').text.strip,
    })
  end
end
