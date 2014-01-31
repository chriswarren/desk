module Desk
  class Client
    module Company

      def company_endpoints
        [ :list, :show, :create, :update, :search, :list_cases ]
      end

    end
  end
end
