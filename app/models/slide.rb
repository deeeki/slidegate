class Slide
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps

  class << self
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

  def site_name
    self.class.name.sub('Slide::', '')
  end
end
