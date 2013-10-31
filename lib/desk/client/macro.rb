module Desk
  class Client
    module Macro

      def macro_endpoints
        [ :list, :show, :create, :update, :delete,
          :list_actions, :show_action, :update_action ]
      end

    end
  end
end
