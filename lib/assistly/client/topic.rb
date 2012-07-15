module Assistly
  class Client
    # Defines methods related to topics
    module Topic
      # Returns extended information of topics
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Assistly.topics
      #     Assistly.topics(:count => 5)
      #     Assistly.topics(:count => 5, :page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/topics/show
      def topics(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("topics",options)
        response
      end
      
      # Returns extended information on a single topic
      #
      #   @param id [Integer] a topic ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Assistly.topic(12345)
      #     Assistly.topic(12345, :by => "external_id")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/topics/show
      def topic(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("topics/#{id}",options)
        response.topic
      end
      
      # Creates a new topic
      #
      #   @param name [String] A topic name
      #   @option options [Hash]
      #   @example Creates a new topic
      #     Assistly.create_topic("name")
      #     Assistly.create_topic("name", :description => "description")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/topics/create
      def create_topic(name, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = post("topics",options)
        if response['success']
          return response['results']['topic']
        else
          return response
        end
      end
      
      # Updates a single topic
      #
      #   @param id [Integer] a topic ID
      #   @option options [String]
      #   @example Updates information for topic 12345
      #     Assistly.update_topic(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/topics/update
      def update_topic(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = put("topics/#{id}",options)
        if response['success']
          return response['results']['topic']
        else
          return response
        end
      end
      
      # Deletes a single topic
      #
      #   @param id [Integer] a topic ID
      #   @example Deletes topic 12345
      #     Assistly.update_topic(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/topics/update
      def delete_topic(id)
        response = delete("topics/#{id}")
        response
      end
    end
  end
end
