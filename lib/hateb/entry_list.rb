require 'hateb/entry'
require 'cgi'

module Hateb
  class EntryList
    BASE_URL = 'http://b.hatena.ne.jp/entrylist'
    PER = 20
    REQUEST_LIMIT = 5

    class << self
      def agent
        @agent ||= Mechanize.new
      end

      def fetch url, offset: 0, since_eid: 0, limit: 100
        limit = REQUEST_LIMIT * PER if limit > REQUEST_LIMIT * PER
        entries, max_offset = [], offset + limit
        begin
          entries.concat(_fetch(url, offset))
          offset += PER
        end while offset < max_offset && entries.last && entries.last.eid >= since_eid
        entries.take_while{|e| e.eid > since_eid }.take(limit)
      end

      private

      def _fetch url, offset = 0
        request_url = "#{BASE_URL}?sort=eid&layout=headline&url=#{CGI.escape(url)}&of=#{offset}"
        page = agent.get(request_url)
        page.search('li.entrylist-unit').take(PER).map do |e|
          Entry.new_from_element(e)
        end
      end
    end
  end
end
