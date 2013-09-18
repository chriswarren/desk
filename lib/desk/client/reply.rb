module Desk
  class Client
    module Reply

      def list_replies(case_id, reply_id = nil)
        specific_reply = reply_id ? "/#{reply_id}" : ""
        get("cases/#{case_id}/replies#{specific_reply}")
      end
      alias_method :replies, :list_replies
      alias_method :show_reply, :list_replies
      alias_method :reply, :list_replies

      def create_reply(case_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        post("cases/#{case_id}/replies", options)
      end

      def update_reply(case_id, reply_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        patch("cases/#{case_id}/replies/#{reply_id}", options)
      end

    end
  end
end
