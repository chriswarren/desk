module Desk
  # @private
  module Authentication
    module Methods
      OAUTH = "oauth"
      BASIC = "basic"
      ALL = [
        OAUTH,
        BASIC,
      ]
    end

    private

    # Authentication hash
    #
    # @return [Hash]
    def authentication
      if auth_method == Methods::BASIC
        basic_authentication
      else
        oauth_authentication
      end
    end

    # Authentication hash for OAUTH connections
    #
    # @return [Hash]
    def oauth_authentication
      {
        :consumer_key => consumer_key,
        :consumer_secret => consumer_secret,
        :token => oauth_token,
        :token_secret => oauth_token_secret
      }
    end

    # Authentication hash for Basic auth connections
    #
    # @return [Hash]
    def basic_authentication
      {
        :username => basic_auth_username,
        :password => basic_auth_password
      }
    end

    # Check whether user is authenticated
    #
    # @return [Boolean]
    def authenticated?
      authentication.values.all?
    end
  end
end
