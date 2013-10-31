require 'faraday'

module Faraday
  class Request::OAuth < Faraday::Middleware
    dependency 'simple_oauth'

    def call(env)
      params = env[:body] || {}
break
      signature_params = params.reject{ |k,v| v.respond_to?(:content_type) || (env[:method] == :put) }

      #header = SimpleOAuth::Header.new(env[:method], env[:url], signature_params, @options)
      # Runscope Support
      realURL = env[:url].sub(/-desk-com-(\w)+.runscope.net/, ".desk.com")
      header = SimpleOAuth::Header.new(env[:method], realURL, signature_params, @options)
      env[:request_headers]['theURL'] = realURL
      env[:request_headers]['Authorization'] = header.to_s

      @app.call(env)
    end

    def initialize(app, options)
      @app, @options = app, options
    end
  end
end
