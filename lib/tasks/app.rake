namespace :app do
  namespace :collect do
    desc 'Collect from SlideShare'
    task all: [:slideshare, :speakerdeck]

    desc 'Collect from SlideShare'
    task slideshare: :environment do
      Rails.application.eager_load! # to prevent `Slideshare` naming problem
      eid = Slide::Slideshare.order(eid: :desc).first.try(:eid) || 0
      Collector.new(:slideshare).collect(since_eid: eid)
    end

    desc 'Collect from Speakerdeck'
    task speakerdeck: :environment do
      eid = Slide::Speakerdeck.order(eid: :desc).first.try(:eid) || 0
      Collector.new(:speakerdeck).collect(since_eid: eid)
    end
  end

  desc 'Synchronize bookmarks counts'
  task sync_bookmarks_counts: :environment do
    per, offset = 50, 0
    limit, all = ENV['SYNC_LIMIT'] || 250, ENV['SYNC_ALL']
    begin
      urls = Slide.order(created_at: :desc).skip(offset).limit(per).pluck(:url)
      break if urls.empty?
      Hateb::EntryCounts.fetch(urls).each do |url, count|
        Slide.where(url: url).update(bookmarks_count: count)
      end
      offset += per
    end while offset < limit || all
  end
end
