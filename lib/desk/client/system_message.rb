module Desk
  class Client
    module SystemMessage

      def show_system_message
        get("system_message")
      end
      alias_method :system_message, :show_system_message

      def system_message_id(href, parent_id = false)
        nil
      end

    end
  end
end
