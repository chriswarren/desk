module Assistly
  # Wrapper for the Assistly REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in {http://dev.assistly.com/doc the Assistly API Documentation}.
  # @see http://dev.assistly.com/pages/every_developer
  class Client < API
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'assistly/client/utils'
    require 'assistly/client/user'
    require 'assistly/client/interaction'
    require 'assistly/client/case'
    require 'assistly/client/customer'
    require 'assistly/client/topic'
    require 'assistly/client/article'

    alias :api_endpoint :endpoint

    include Assistly::Client::Utils

    include Assistly::Client::User
    include Assistly::Client::Interaction
    include Assistly::Client::Case
    include Assistly::Client::Customer
    include Assistly::Client::Topic
    include Assistly::Client::Article
  end
end
