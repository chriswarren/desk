module Assistly
  class Client
    # Defines methods related to interactions
    module Interaction
      # Returns extended information of interactions
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Assistly.interactions(:since_id => 12345)
      #     Assistly.interactions(:since_id => 12345, :count => 5)
      # @format :json, :xml
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/users/show
      def interactions(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("interactions",options)
        response['results']
      end

      # Returns extended information for up to 100 users
      #
      # @format :json, :xml
      # @authenticated true
      # @rate_limited true
      # @return [Array] The requested users.
      # @see http://dev.twitter.com/doc/get/users/lookup
      # @example Return extended information account users
      #   Assistly.users
      def create_interaction(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = post('interactions', options)
        if response['success']
          return response['results']
        else
          return response['errors']
        end
      end
    end
  end
end
