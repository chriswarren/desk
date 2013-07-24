module Desk
  class Client
    # Defines methods related to cases
    module Case
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
      def cases(*args)
        if args.last.is_a?(Hash)
          options = args.pop
          get("cases/search", options)
        else
          get("cases")
        end
      end

      # Returns extended information on a single case
      #
      #   @option options [String]
      #   @example Return extended information for 12345
      #     Desk.case(12345)
      #     Desk.case(12345, :by => "external_id")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/cases/show
      def case(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("cases/#{id}",options)
      end

      def create_case(customer_id, *args)
        # TODO check for required args; throw error(s)
        options = args.last.is_a?(Hash) ? args.pop : {}
        post("customers/#{customer_id}/cases", options)
      end

      # Updates a single case
      #
      #   @option options [String]
      #   @example Return extended information for 12345
      #     Desk.update_case(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/cases/update
      def update_case(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        put("cases/#{id}",options)
      end

      def message(id)
        get("cases/#{id}/message")
      end

      def replies(id)
        get("cases/#{id}/replies")
      end

      def reply(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        post("cases/#{id}/replies", options)
      end

      def case_url(id)
        "https://#{subdomain}.desk.com/agent/case/#{id}"
      end
    end
  end
end
