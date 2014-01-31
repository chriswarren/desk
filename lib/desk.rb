require 'desk/error'
require 'desk/configuration'
require 'desk/api'
require 'desk/client'
require 'pony'

module Desk
  extend Configuration
  @counter = 0
  @minute = Time.now.min

  class << self
    attr_accessor :counter, :minute

    # Alias for Desk::Client.new
    #
    # @return [Desk::Client]
    def client(options={})
      Desk::Client.new(options)
    end

    # Delegate to Desk::Client
    def method_missing(method, *args, &block)
      return super unless client.respond_to?(method)
      client.send(method, *args, &block)
    end

    def respond_to?(method)
      client.respond_to?(method) || super
    end
  end
end
