module Desk
  class Client
    module Mailbox

      def mailbox_list_inbound(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("mailboxes/inbound", options)
      end
      alias_method :inbound_mailboxes, :mailbox_list_inbound
      alias_method :list_inbound_mailboxes, :mailbox_list_inbound

      def mailbox_show_inbound(mailbox_id)
        get("mailboxes/inbound/#{mailbox_id}")
      end
      alias_method :inbound_mailbox, :mailbox_show_inbound
      alias_method :show_inbound_mailbox, :mailbox_show_inbound

    end
  end
end
