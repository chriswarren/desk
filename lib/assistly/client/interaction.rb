module Assistly
  class Client
    # Defines methods related to interactions
    module Interaction
      
      # Returns extended information of up to 100 interactions
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Assistly.interactions(:since_id => 12345)
      #     Assistly.interactions(:since_id => 12345, :count => 5)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/interactions
      def interactions(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("interactions",options)
        response
      end
      
      def create_interaction(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        if options[:direction].to_s == "outbound"
          options.delete(:direction)
          to      = options.delete(:customer_email)
          subject = options.delete(:interaction_subject)
          body    = options.delete(:interaction_body)
          
          create_outbound_interaction(to, subject, body, options)
        else
          create_inbound_interaction(options)
        end
      end

      # Creates an interaction from a customer
      #
      # @format :json
      # @authenticated true
      # @rate_limited true
      # @return [Array] The requested users.
      # @see http://dev.desk.com/docs/api/interactions/create
      # @example Create a new interaction
      #   Assistly.create_interaction(:interaction_subject => "this is an api test", :customer_email => "foo@example.com")
      def create_inbound_interaction(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = post('interactions', options)
        if response['success']
          return response['results']
        else
          return response
        end
      end
      
      # Create an interaction from an agent
      # 
      # Assistly's API doesn't support creating a new case/interaction initiated by an agent
      # so we'll use send an email to the customer directly that is BCC'd to the support email address
      # which will create the ticket
      # 
      # @see http://support.desk.com/customer/portal/articles/4180
      # @see http://support.desk.com/customer/portal/articles/6728
      def create_outbound_interaction(to, subject, body, *args)
        raise Assistly::SupportEmailNotSet if support_email.blank?
        options = args.last.is_a?(Hash) ? args.pop : {}
        options.merge!(:to => to, :subject => subject, :body => body, :from => support_email, :bcc => support_email)
        headers = { "x-assistly-customer-email" => to, 
                    "x-assistly-interaction-direction" => "out",
                    "x-assistly-case-status" => options[:status]||"open"}
        headers.merge!(options[:headers]) if options[:headers]
        options.merge!(:headers => headers)
        Pony.mail(options)
      end
    end
  end
end
