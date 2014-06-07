class Slide
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps

  field :published_at, type: Time
  field :bookmarked_at, type: Time

  scope :bookmarked_on, ->(on = Date.today){
    from = on.to_time.beginning_of_day
    where(:bookmarked_at.gte => from, :bookmarked_at.lte => from.end_of_day)
  }
  scope :bookmarked_within, ->(from, to = Time.now) {
    where(:bookmarked_at.gte => from, :bookmarked_at.lte => to)
  }

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
