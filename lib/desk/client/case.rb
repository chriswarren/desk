module Desk
  class Client
    # Defines methods related to cases
    module Case

      def case_fns
        [ :list, :search, :create, :update, 
          :list_message,
          :list_replies, :show_reply, :create_reply, :update_reply,
          :list_notes, :show_note, :create_note,
          :list_attachments, :show_attachment, :create_attachment, :delete_attachment,
          :list_history
        ]
      end

      def show_case(case_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        case_id = "e-#{case_id}" if options[:by] == "external_id"
        get("cases/#{case_id}")
      end
      alias_method :case, :show_case

      def list_message_attachments(case_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("cases/#{case_id}/message/attachments", options)
      end
      alias_method :message_attachments, :list_message_attachments

      def list_reply_attachments(case_id, reply_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("cases/#{case_id}/replies/#{reply_id}/attachments", options)
      end
      alias_method :reply_attachments, :list_reply_attachments

      def show_message_attachment(case_id, attachment_id)
        get("cases/#{case_id}/message/attachments/#{attachment_id}")
      end
      alias_method :message_attachment, :show_message_attachment

      def show_reply_attachment(case_id, reply_id, attachment_id)
        get("cases/#{case_id}/replies/#{reply_id}/attachments/#{attachment_id}")
      end
      alias_method :reply_attachment, :show_reply_attachment

      def create_message_attachment(case_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        post("cases/#{case_id}/message/attachments", options)
      end

      def create_reply_attachment(case_id, reply_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        post("cases/#{case_id}/replies/#{reply_id}/attachments", options)
      end

      def delete_message_attachment(case_id, attachment_id)
        delete("cases/#{case_id}/message/attachments/#{attachment_id}")
      end

      def delete_reply_attachment(case_id, reply_id, attachment_id)
        delete("cases/#{case_id}/replies/#{reply_id}/attachments/#{attachment_id}")
      end

      def case_url(case_id)
        "https://#{subdomain}.desk.com/agent/case/#{case_id}"
      end
    end
  end
end
