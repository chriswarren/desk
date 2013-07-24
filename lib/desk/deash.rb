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
    # Object#type is deprecated 
    Mash.send :undef_method, :type

    def each
      if includes_key_chain?("raw._embedded.entries")
        self.raw._embedded['entries'].each do |entry|
          yield entry
        end
      else
        super
      end
    end

    def method_missing(method, *args, &block)
      return self.[](method) if key?(method)
      # TODO: Make this DRY
      if includes_key_chain?("_links."+method.to_s)
        return nil if !self._links[method]
        return Desk.get(self._links[method].href.sub("/api/#{self.version}/", ""))
      elsif includes_key_chain?("raw._links."+method.to_s)
        return nil if !self.raw._links[method]
        return Desk.get(self.raw._links[method].href.sub("/api/#{self.version}/", ""))
      elsif includes_key_chain?("raw."+method.to_s)
        return nil if !self.raw[method]
        return self.raw[method]
      end
      return super
    end

    def id
      if includes_key_chain?("raw._links.self.href")
        case self._links.self['class']
        when 'case', 'phone_call'
          self._links.self.href.split("/")[4].to_i
        end
      end
    end

    def includes_key_chain?(chain)
      current_chain = self
      chain.split(".").each do |k|
        return false if !current_chain.key?(k)
        current_chain = current_chain[k]
      end
      true
    end

    def links
      Links.new(self._links) if key?("_links")
      Links.new(self.raw._links) if includes_key_chain?("raw._links")
    end

    def results
      self._embedded['entries'] if key?('_embedded') && self._embedded.key?('entries')
    end

  end
end
