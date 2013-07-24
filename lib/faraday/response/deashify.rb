require 'faraday_middleware/response/mashify'

module FaradayMiddleware
  # Public: Converts parsed response bodies to a Hashie::Rash if they were of
  # Hash or Array type.
  class Deashify < Mashify
    dependency do
      require 'desk/deash'
      self.mash_class = ::Hashie::Deash
    end

    def parse(body)
      case body
      when Hash
        raw = mash_class.new({:raw => body})
      when Array
        raw = body.map { |item| parse(item) }
      else
        raw = body
      end
    end
  end
end
