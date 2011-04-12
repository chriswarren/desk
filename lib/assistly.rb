require 'assistly/error'
require 'assistly/configuration'
require 'assistly/api'
require 'assistly/client'
# require 'assistly/search'

module Assistly
  extend Configuration

  # Alias for Assistly::Client.new
  #
  # @return [Assistly::Client]
  def self.client(options={})
    Assistly::Client.new(options)
  end

  # Delegate to Assistly::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method)
    client.respond_to?(method) || super
  end
end
