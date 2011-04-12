module Assistly
  class Client
    # Defines methods related to interactions
    module Interaction
      
      # Returns extended information of up to 100 interactions
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Assistly.interactions(:since_id => 12345)
      #     Assistly.interactions(:since_id => 12345, :count => 5)
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/interactions
      def interactions(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("interactions",options)
        response['results']
      end

      # Creates an interaction
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @return [Array] The requested users.
      # @see http://dev.assistly.com/docs/api/interactions/create
      # @example Create a new interaction
      #   Assistly.create_interaction(:interaction_subject => "this is an api test", :customer_email => "foo@example.com")
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
