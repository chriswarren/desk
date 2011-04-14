require 'assistly/connection'
require 'assistly/request'
require 'assistly/authentication'

module Assistly
  # @private
  class API
    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    # Creates a new API
    def initialize(options={})
      options = Assistly.options.merge(options)
      
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end
    
    def endpoint
      "https://#{self.subdomain}.assistly.com/api/#{self.version}/"
    end

    include Connection
    include Request
    include Authentication
  end
end
