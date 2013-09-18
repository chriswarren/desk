module Desk
  class Client
    # Defines methods related to customers
    module Customer
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

      # Returns extended information on a single customer
      #
      #   @option options [String]
      #   @example Return extended information for customer 12345
      #     Desk.customer(12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/customers/show
      def show_customer(customer_id)
        get("customers/#{customer_id}")
      end
      alias_method :customer, :show_customer

      # Create a new customer
      #
      #   @option options [String]
      #   @example Return extended information for 12345
      #     Desk.create_customer(:name => "Chris Warren", :twitter => "cdwarren")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/customers/create
      def create_customer(*args)
        # TODO check for required args; throw error(s)
        options = args.last.is_a?(Hash) ? args.pop : {}
        post("customers", options)
      end

      # Update a customer
      #
      #   @option options [String]
      #   @example Return extended information for 12345
      #     Desk.update_customer(12345, :name => "Christopher Warren")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/customers/update
      def update_customer(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        patch("customers/#{id}",options)
      end
    end
  end
end
