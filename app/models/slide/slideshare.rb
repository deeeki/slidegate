class Slide::Slideshare < Slide
  class << self
    def url_valid? url
      !!(url =~ %r[\Ahttps?://www\.slideshare\.net/[^/]+/[^/]+\z] &&
        url !~ %r[slideshare\.net/search/] && url !~ %r[slideshare\.net/[^/]+/(slideshelf|newsfeed)])
    end
  end

  def fetch
    return unless url
    api_slide = ::Slideshare.get_slideshow(slideshow_url: url, detailed: 1).slideshow
    assign_attributes({
      slide_id: api_slide.id,
      title: api_slide.title,
      description: api_slide.description,
      thumbnail_url: api_slide.thumbnail_small_url,
      published_at: Time.parse(api_slide.created),
      downloadable: api_slide.download == '1',
      author_id: api_slide.user_id,
      author_name: api_slide.username,
      tags: api_slide.tags.kind_of?(Hash) ? Array(api_slide.tags.tag) : [],
    })
  end
end
