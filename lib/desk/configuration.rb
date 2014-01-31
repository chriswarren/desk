require 'faraday'
require 'desk/version'

module Desk
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {Twitter::API}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :consumer_key,
      :consumer_secret,
      :format,
      :max_requests,
      :oauth_token,
      :oauth_token_secret,
      :proxy,
      :subdomain,
      :support_email,
      :use_max_requests,
      :user_agent,
      :version].freeze

    # An array of valid request/response formats
    #
    # @note Not all methods support the XML format.
    VALID_FORMATS = [
      :json].freeze

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set an application key
    DEFAULT_CONSUMER_KEY = nil

    # By default, don't set an application secret
    DEFAULT_CONSUMER_SECRET = nil

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is preferred over XML because it is more concise and faster to parse.
    DEFAULT_FORMAT = :json
    
    # By default, set the max requests to 60 per minute
    DEFAULT_MAX_REQUESTS = 60

    # By default, don't use the max request feature
    DEFAULT_USE_MAX_REQUESTS = false

    # By default, don't set a user oauth token
    DEFAULT_OAUTH_TOKEN = nil

    # By default, don't set a user oauth secret
    DEFAULT_OAUTH_TOKEN_SECRET = nil

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # By default use example
    DEFAULT_SUBDOMAIN = "example"

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Desk.com Ruby Gem #{Desk::VERSION}".freeze

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_VERSION = "v2".freeze

    # By default, don't set a support email address
    DEFAULT_SUPPORT_EMAIL = nil

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      Hash[VALID_OPTIONS_KEYS.map {|key| [key, send(key)] }]
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter            = DEFAULT_ADAPTER
      self.consumer_key       = DEFAULT_CONSUMER_KEY
      self.consumer_secret    = DEFAULT_CONSUMER_SECRET
      self.format             = DEFAULT_FORMAT
      self.max_requests       = DEFAULT_MAX_REQUESTS
      self.oauth_token        = DEFAULT_OAUTH_TOKEN
      self.oauth_token_secret = DEFAULT_OAUTH_TOKEN_SECRET
      self.proxy              = DEFAULT_PROXY
      self.subdomain          = DEFAULT_SUBDOMAIN
      self.support_email      = DEFAULT_SUPPORT_EMAIL
      self.use_max_requests   = DEFAULT_USE_MAX_REQUESTS
      self.user_agent         = DEFAULT_USER_AGENT
      self.version            = DEFAULT_VERSION
      self
    end
  end
end
