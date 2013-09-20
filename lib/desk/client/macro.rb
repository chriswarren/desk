module Desk
  class Client
    # Defines methods related to macros
    module Macro

      def macro_fns
        [ :list, :show, :create, :update, :delete,
          :list_actions, :show_action, :update_action ]
      end

    end
  end
end
