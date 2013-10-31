module Desk
  class Client
    module IntegrationUrl

      def integration_url_endpoints
        [ :list, :show, :create, :update, :delete ]
      end

    end
  end
end
