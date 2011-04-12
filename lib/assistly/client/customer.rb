module Assistly
  class Client
    # Defines methods related to customers
    module Customer
      # Returns extended information of customers
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for customers
      #     Assistly.customers
      #     Assistly.customers(:since_id => 12345, :count => 5)
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/customers
      def customers(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("customers",options)
        response['results']
      end
      
      # Returns extended information on a single customer
      #
      #   @option options [String]
      #   @example Return extended information for customer 12345
      #     Assistly.customer(12345)
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/customers/show
      def customer(id)
        response = get("customers/#{id}")
        response.customer
      end

      # Create a new customer
      #
      #   @option options [String]
      #   @example Return extended information for 12345
      #     Assistly.create_customer(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/customers/create
      def create_customer(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = post("customers",options)
        if response['success']
          return response['results']['customer']
        else
          return response['errors']
        end
      end
      
      # Update a customer
      #
      #   @option options [String]
      #   @example Return extended information for 12345
      #     Assistly.update_customer(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/customers/update
      def update_customer(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = put("customers/#{id}",options)
        if response['success']
          return response['results']['customer']
        else
          return response['errors']
        end
      end
      
      # Create a new customer email
      #
      #   @option options [String]
      #   @example Return extended information for 12345
      #     Assistly.create_customer_email(12345, "foo@example.com")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/customers/emails/create
      def create_customer_email(id, email)
        response = post("customers/#{id}/emails",:email => email)
        if response['success']
          return response['results']['email']
        else
          return response['errors']
        end
      end
      
      # Update a customer's email
      #
      #   @option options [String]
      #   @example Return extended information for 12345
      #     Assistly.update_customer_email(12345, 12345, "foo@example.com")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/customers/emails/update
      def update_customer_email(id, email_id, email)
        response = put("customers/#{id}/emails/#{email_id}",:email => email)
        if response['success']
          return response['results']['email']
        else
          return response['errors']
        end
      end
    end
  end
end
