require 'cgi'

module Hateb
  class EntryCounts
    BASE_URL = 'http://api.b.st-hatena.com/entry.counts'

    class << self
      def fetch *urls
        request_url = "#{BASE_URL}?#{urls.flatten.map{|url| "url=#{CGI.escape(url)}" }.join('&')}"
        JSON.parse(open(request_url).read)
      end
    end
  end
end
