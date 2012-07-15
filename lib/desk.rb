require 'desk/error'
require 'desk/configuration'
require 'desk/api'
require 'desk/client'
require 'pony'

module Desk
  extend Configuration

  # Alias for Desk::Client.new
  #
  # @return [Desk::Client]
  def self.client(options={})
    Desk::Client.new(options)
  end

  # Delegate to Desk::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method)
    client.respond_to?(method) || super
  end
end
