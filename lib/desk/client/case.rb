module Desk
  class Client
    # Defines methods related to cases
    module Case

      def case_fns
        [ :create, :update, 
          :list_replies, :show_reply, :create_reply, :update_reply,
          :list_notes, :show_note, :create_note]
      end
      # Returns extended information of cases
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Desk.cases(:case_id => 12345)
      #     Desk.cases(:email => "customer@example.com", :count => 5)
      #     Desk.cases(:since_id => 12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/cases/show
      def list_cases(*args)
        # TODO searchs fail when only page, per_page, etc args are passed
        if args.last.is_a?(Hash)
          options = args.pop
          get("cases/search", options)
        else
          get("cases")
        end
      end
      alias_method :cases, :list_cases

      # Returns extended information on a single case
      #
      #   @option options [String]
      #   @example Return extended information for 12345
      #     Desk.case(12345)
      #     Desk.case(12345, :by => "external_id")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/cases/show
      def show_case(case_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        case_id = "e-#{case_id}" if options[:by] == "external_id"
        get("cases/#{case_id}")
      end
      alias_method :case, :show_case

      def show_message(case_id)
        get("cases/#{case_id}/message")
      end
      alias_method :message, :show_message

      def case_url(case_id)
        "https://#{subdomain}.desk.com/agent/case/#{case_id}"
      end
    end
  end
end
