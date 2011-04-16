module Assistly
  class Client
    # Defines methods related to articles
    module Article
      # Returns extended information of articles for a topic
      #
      #   @param id [Integer] a article ID
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Assistly.articles
      #     Assistly.articles(:count => 5)
      #     Assistly.articles(:count => 5, :page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/topics/articles
      def articles(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("topics/#{id}/articles",options)
        if response['results']
          return response['results']
        else
          return response
        end
      end
      
      # Returns extended information on a single article
      #
      #   @param id [Integer] a article ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Assistly.article(12345)
      #     Assistly.article(12345, :by => "external_id")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/articles/show
      def article(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("articles/#{id}",options)
        response.article
      end
      
      # Creates a new article
      #
      #   @param id [Integer] a article ID
      #   @param id [Integer] a article ID
      #   @param id [Integer] a article ID
      #   @option options [Hash]
      #   @example Creates a new article
      #     Assistly.create_article(1, :subject => "API Tips", :main_content => "Tips on using our API")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/articles/create
      def create_article(topic_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = post("topics/#{topic_id}/articles",options)
        if response['success']
          return response['results']['article']
        else
          return response
        end
      end
      
      # Updates a single article
      #
      #   @param id [Integer] a article ID
      #   @option options [String]
      #   @example Updates information for article 12345
      #     Assistly.update_article(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/articles/update
      def update_article(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = put("articles/#{id}",options)
        if response['success']
          return response['results']['article']
        else
          return response
        end
      end
      
      # Deletes a single article
      #
      #   @param id [Integer] a article ID
      #   @example Deletes article 12345
      #     Assistly.update_article(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/articles/update
      def delete_article(id)
        response = delete("articles/#{id}")
        response
      end
    end
  end
end
