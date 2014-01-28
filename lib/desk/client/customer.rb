module Desk
  class Client
    module Customer

      def customer_endpoints
        [ :list, :show, :create, :update, :search ]
      end

      def customer_add_key(key, customer, value, type)
        customer.send(key) << {:value => value, :type => type}
        customer = Desk.update_customer(customer.id, {key.to_sym => customer.send(key)})
      end

      def customer_delete_key(key, customer, *args)
        a = args.last.is_a?(Array) ? args.pop : args
        customer.send(key).delete_if do |item|
          a.include?(item.type) || a.include?(item.value)
        end
        customer = Desk.update_customer(customer.id, {key.to_sym => customer.send(key)})
      end

      def customer_add_address(customer, address, type = "home")
        customer_add_key("addresses", customer, address, type)
      end

      def customer_delete_address(customer, *args)
        customer_delete_key("addresses", customer, args)
      end

      def customer_add_email(customer, email, type = "home")
        customer_add_key("emails", customer, email, type)
      end

      def customer_delete_email(customer, *args)
        customer_delete_key("emails", customer, args)
      end

      def customer_add_phone_number(customer, phone_number, type = "home")
        customer_add_key("phone_numbers", customer, phone_number, type)
      end

      def customer_delete_phone_number(customer, *args)
        customer_delete_key("phone_numbers", customer, args)
      end

    end
  end
end
