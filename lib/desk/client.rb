module Desk
  # Wrapper for the Desk.com REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in {http://dev.desk.com/doc the Desk.com API Documentation}.
  # @see http://dev.desk.com/pages/every_developer
  class Client < API
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'desk/client/attachment'
    require 'desk/client/user'
    require 'desk/client/group'
    require 'desk/client/reply'
    require 'desk/client/note'
    require 'desk/client/case'
    require 'desk/client/customer'
    require 'desk/client/topic'
    require 'desk/client/article'
    require 'desk/client/macro'

    alias :api_endpoint :endpoint

    include Desk::Client::Attachment
    include Desk::Client::User
    include Desk::Client::Group
    include Desk::Client::Reply
    include Desk::Client::Note
    include Desk::Client::Case
    include Desk::Client::Customer
    include Desk::Client::Topic
    include Desk::Client::Article
    include Desk::Client::Macro
  end
end
