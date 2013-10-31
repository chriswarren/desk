module Desk
  class Client
    module Rule

      def rule_endpoints
        [ :list, :show ]
        # PLANNED
        # [ :list_actions, :show_actions,
        #   :list_conditions, :show_conditions ]
      end

    end
  end
end
