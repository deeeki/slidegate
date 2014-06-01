class Collector
  SITES = {
    slideshare: 'www.slideshare.net',
    speakerdeck: 'speakerdeck.com',
  }

  def initialize site
    @site_url, @model_class = SITES[site], "Slide::#{site.capitalize}".constantize
  end

  def collect options = {}
    Hateb::EntryList.fetch(@site_url, options).each do |entry|
      save(entry) if @model_class.valid_url?(entry.url) && !@model_class.where(url: entry.url).exists?
    end
  end

  def save entry
    slide = @model_class.new_from_entry(entry)
    slide.fetch
    slide.save
  rescue Mechanize::ResponseCodeError, Slideshare::APIError => e
    Rails.logger.error(e)
  end
end
