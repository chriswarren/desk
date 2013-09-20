module Desk
  class Client
    # Defines methods related to customers
    module Customer

      def customer_fns
        [ :show, :create, :update ]
      end

      # Returns extended information of customers
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for customers
      #     Desk.customers
      #     Desk.customers(:since_id => 12345, :count => 5)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/customers
      def list_customers(*args)
        # TODO searchs fail when only page, per_page, etc args are passed
        if args.last.is_a?(Hash)
          options = args.pop
          get("customers/search", options)
        else
          get("customers")
        end
      end
      alias_method :customers, :list_customers
    end
  end
end
