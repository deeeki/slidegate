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
end
