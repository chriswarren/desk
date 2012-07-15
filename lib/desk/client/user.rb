module Desk
  class Client
    # Defines methods related to users
    module User
      # Returns extended information of a given user
      #
      # @overload user(user, options={})
      #   @param user [Integer] An Assitely user ID
      #   @option options [Boolean, String, Integer] :include_entities Include {http://dev.twitter.com/pages/tweet_entities Tweet Entities} when set to true, 't' or 1.
      #   @return [Hashie::Mash] The requested user.
      #   @example Return extended information for 12345
      #     Desk.user(12345)
      # @format :json, :xml
      # @authenticated true
      # @see http://dev.desk.com/docs/api/users/show
      def user(id,*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("users/#{id}",options)
        response.user
      end

      # Returns extended information for up to 100 users
      #
      # @format :json, :xml
      # @authenticated true
      # @rate_limited true
      # @return [Array] The requested users.
      # @see http://dev.desk.com/docs/api/users
      # @example Return extended information account users
      #   Desk.users
      def users(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get('users', options)
        response
      end
    end
  end
end
