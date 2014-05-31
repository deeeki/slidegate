require 'hateb/entry'
require 'cgi'

module Hateb
  class EntryList
    BASE_URL = 'http://b.hatena.ne.jp/entrylist'

    class << self
      def agent
        @agent ||= Mechanize.new
      end

      def fetch url, offset = nil
        request_url = "#{BASE_URL}?sort=eid&url=#{CGI.escape(url)}&of=#{offset}"
        page = agent.get(request_url)
        page.search('li.entry-unit').take(20).map do |e|
          Entry.new_from_element(e)
        end
      end
    end
  end
end
