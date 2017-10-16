require 'faraday'
require 'desk/version'
require 'desk/authentication'

module Desk
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {Twitter::API}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :auth_method,
      :basic_auth_username,
      :basic_auth_password,
      :consumer_key,
      :consumer_secret,
      :domain,
      :format,
      :logger,
      :max_requests,
      :oauth_token,
      :oauth_token_secret,
      :proxy,
      :subdomain,
      :support_email,
      :use_max_requests,
      :user_agent,
      :timeout,
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

    # By default, OAUTH is selected
    DEFAULT_AUTH_METHOD = Desk::Authentication::Methods::OAUTH

    # By default, don't set a username
    DEFAULT_BASIC_AUTH_USERNAME = nil

    # By default, don't set a password
    DEFAULT_BASIC_AUTH_PASSWORD = nil

    # By default, use the desk.com hosted domain
    DEFAULT_DOMAIN = "desk.com"

    # By default, don't set an application key
    DEFAULT_CONSUMER_KEY = nil

    # By default, don't set an application secret
    DEFAULT_CONSUMER_SECRET = nil

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is preferred over XML because it is more concise and faster to parse.
    DEFAULT_FORMAT = :json

    # The logger that will be used to log all HTTP requests
    #
    # @note By default, don't set any logger
    DEFAULT_LOGGER = nil

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

    # By default, don't set a default timeout
    DEFAULT_TIMEOUT = nil

    attr_reader :DEFAULT_ADAPTER
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

    def adapter
      Thread.current[:adapter] ||= DEFAULT_ADAPTER
    end

    def adapter=(val)
      Thread.current[:adapter] = val
    end

    def auth_method
      Thread.current[:auth_method] ||= DEFAULT_ADAPTER
    end

    def auth_method=(val)
      Thread.current[:auth_method] = val
    end

    def consumer_key
      Thread.current[:consumer_key] ||= DEFAULT_CONSUMER_KEY
    end

    def consumer_key=(val)
      Thread.current[:consumer_key] = val
    end

    def consumer_secret
      Thread.current[:consumer_secret] ||= DEFAULT_CONSUMER_SECRET
    end

    def consumer_secret=(val)
      Thread.current[:consumer_secret] = val
    end

    def domain
      Thread.current[:domain] ||= DEFAULT_DOMAIN
    end

    def domain=(val)
      Thread.current[:domain] = val
    end

    def format
      Thread.current[:format] ||= DEFAULT_FORMAT
    end

    def format=(val)
      Thread.current[:format] = val
    end

    def logger
      Thread.current[:logger] ||= DEFAULT_LOGGER
    end

    def logger=(val)
      Thread.current[:logger] = val
    end

    def max_requests
      Thread.current[:max_requests] ||= DEFAULT_MAX_REQUESTS
    end

    def max_requests=(val)
      Thread.current[:max_requests] = val
    end

    def oauth_token
      Thread.current[:oauth_token] ||= DEFAULT_OAUTH_TOKEN
    end

    def oauth_token=(val)
      Thread.current[:oauth_token] = val
    end

    def oauth_token_secret
      Thread.current[:oauth_token_secret] ||= DEFAULT_OAUTH_TOKEN_SECRET
    end

    def oauth_token_secret=(val)
      Thread.current[:oauth_token_secret] = val
    end

    def proxy
      Thread.current[:proxy] ||= DEFAULT_PROXY
    end

    def proxy=(val)
      Thread.current[:proxy] = val
    end

    def subdomain
      Thread.current[:subdomain] ||= DEFAULT_SUBDOMAIN
    end

    def subdomain=(val)
      Thread.current[:subdomain] = val
    end

    def support_email
      Thread.current[:support_email] ||= DEFAULT_SUPPORT_EMAIL
    end

    def support_email=(val)
      Thread.current[:support_email] = val
    end

    def use_max_requests
      Thread.current[:use_max_requests] ||= DEFAULT_USE_MAX_REQUESTS
    end

    def use_max_requests=(val)
      Thread.current[:use_max_requests] = val
    end

    def user_agent
      Thread.current[:user_agent] ||= DEFAULT_USER_AGENT
    end

    def user_agent=(val)
      Thread.current[:user_agent] = val
    end

    def version
      Thread.current[:version] ||= DEFAULT_VERSION
    end

    def version=(val)
      Thread.current[:version] = val
    end

    def timeout
      Thread.current[:timeout] ||= DEFAULT_TIMEOUT
    end

    def timeout=(val)
      Thread.current[:timeout] = val
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter            = DEFAULT_ADAPTER
      self.auth_method        = DEFAULT_AUTH_METHOD
      self.basic_auth_username= DEFAULT_BASIC_AUTH_USERNAME
      self.basic_auth_password= DEFAULT_BASIC_AUTH_PASSWORD
      self.consumer_key       = DEFAULT_CONSUMER_KEY
      self.consumer_secret    = DEFAULT_CONSUMER_SECRET
      self.domain             = DEFAULT_DOMAIN
      self.format             = DEFAULT_FORMAT
      self.logger             = DEFAULT_LOGGER
      self.max_requests       = DEFAULT_MAX_REQUESTS
      self.oauth_token        = DEFAULT_OAUTH_TOKEN
      self.oauth_token_secret = DEFAULT_OAUTH_TOKEN_SECRET
      self.proxy              = DEFAULT_PROXY
      self.subdomain          = DEFAULT_SUBDOMAIN
      self.support_email      = DEFAULT_SUPPORT_EMAIL
      self.use_max_requests   = DEFAULT_USE_MAX_REQUESTS
      self.user_agent         = DEFAULT_USER_AGENT
      self.version            = DEFAULT_VERSION
      self.timeout            = DEFAULT_TIMEOUT
      self
    end
  end
end
