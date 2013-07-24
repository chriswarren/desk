require 'hashie/mash'

module Hashie
  class Links

    def initialize(links)
      @links = links
    end

    def method_missing(method, *args, &block)
      if @links.key?(method)
        return nil if !@links[method]
        return Desk.get(@links[method].href.sub("/api/#{Desk.version}/", ""))
      end
      return super
    end
  end

  class Deash < Mash

    def method_missing(method, *args, &block)
      return self.[](method) if key?(method)
      if key?("_links") && self._links.key?(method)
        return nil if !self._links[method]
        return Desk.get(self._links[method].href.sub("/api/#{self.version}/", ""))
      end
      return super
    end

    def links
      Links.new(self._links) if key?("_links")
    end

    def each
      if key?('raw') && self.raw.key?('_embedded') && self.raw._embedded.key?('entries')
        self.raw._embedded['entries'].each do |entry|
          yield entry
        end
      else
        super
      end
    end

    def results
      self._embedded['entries'] if key?('_embedded') && self._embedded.key?('entries')
    end

  end
end
