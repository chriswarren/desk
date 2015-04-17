require 'faraday_middleware'
require 'faraday/request/multipart_with_file'
require 'faraday/response/deashify'
require 'faraday/response/raise_http_4xx'
require 'faraday/response/raise_http_5xx'

module Desk
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {'Accept' => "application/#{format}", 'User-Agent' => user_agent},
        :proxy => proxy,
        :ssl => {:verify => false, :version => 'SSLv23'},
        :url => api_endpoint,
      }

      Faraday.new(options) do |builder|
        builder.use Faraday::Request::MultipartWithFile
        builder.use Faraday::Request::OAuth, authentication if authenticated?
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::RaiseHttp4xx
        builder.use FaradayMiddleware::Deashify unless raw
        unless raw
          case format.to_s.downcase
          when 'json'
            builder.use Faraday::Response::ParseJson
          when 'xml'
            builder.use Faraday::Response::ParseXml
          end
        end
        builder.use Faraday::Response::RaiseHttp5xx
        builder.adapter(adapter)
        builder.response :logger, logger, :bodies => true unless logger.nil?
      end
    end
  end
end
