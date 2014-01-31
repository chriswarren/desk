module Desk
  class Client
    module User

      def user_endpoints
        [ :list, :show, :list_preferences, :show_preference, :update_preference ]
      end

    end
  end
end
