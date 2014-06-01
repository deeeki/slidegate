namespace :app do
  namespace :collect do
    desc 'Collect from SlideShare'
    task all: [:slideshare, :speakerdeck]

    desc 'Collect from SlideShare'
    task speakerdeck: :environment do
      Collector.collect_from(:slideshare)
    end

    desc 'Collect from Speakerdeck'
    task speakerdeck: :environment do
      Collector.collect_from(:speakerdeck)
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
