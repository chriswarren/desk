module Desk
  class Client
    module SystemMessage

      def show_system_message
        get("system_message")
      end
      alias_method :system_message, :show_system_message

    end
  end
end
