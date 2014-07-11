class Slide::Speakerdeck < Slide
  class << self
    def agent
      @agent ||= Mechanize.new
    end

    def url_valid? url
      return false if url.include?('sssslide.com')
      url =~ /speakerdeck.com\/(u\/)?[^\/]{2,}\/(p\/)?[^\/]+$/ && url !~ /speakerdeck.com\/(embed|player)\//
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
