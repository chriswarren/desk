module Desk
  class Client
    module TwitterAccount

      def twitter_account_endpoints
        [ :list, :show, :list_tweets, :show_tweet, :create_tweet ]
      end

    end
  end
end
