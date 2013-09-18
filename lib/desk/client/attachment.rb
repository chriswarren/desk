module Desk
  class Client
    module Attachment

      def list_attachments(case_id, reply_id = nil)
        specific_reply = reply_id ? "replies/#{reply_id}/" : ""
        get("cases/#{case_id}/#{specific_reply}attachments")
      end
      alias_method :attachments, :list_attachments
      alias_method :show_attachments, :list_attachments
      alias_method :list_reply_attachments, :list_attachments

      def list_message_attachments(case_id)
        get("cases/#{case_id}/message/attachments")
      end
      alias_method :message_attachments, :list_message_attachments
      alias_method :original_attachments, :list_message_attachments

    end
  end
end
