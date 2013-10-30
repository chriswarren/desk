module Desk
  class Client
    module Customer

      def customer_endpoints
        [ :list, :show, :create, :update, :search ]
      end

    end
  end
end
