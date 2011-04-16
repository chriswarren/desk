module Assistly
  class Client
    # Defines methods related to macros
    module Macro
      # Returns extended information of macros
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Assistly.macros
      #     Assistly.macros(:count => 5)
      #     Assistly.macros(:count => 5, :page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/macros/show
      def macros(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("macros",options)
        response['results']
      end
      
      # Returns extended information on a single macro
      #
      #   @param id [Integer] a macro ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Assistly.macro(12345)
      #     Assistly.macro(12345, :by => "external_id")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/macros/show
      def macro(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("macros/#{id}",options)
        response.macro
      end
      
      # Creates a new macro
      #
      #   @param name [String] A macro name
      #   @option options [Hash]
      #   @example Creates a new macro
      #     Assistly.create_macro("name")
      #     Assistly.create_macro("name", :description => "description")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/macros/create
      def create_macro(name, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = post("macros",options)
        if response['success']
          return response['results']['macro']
        else
          return response
        end
      end
      
      # Updates a single macro
      #
      #   @param id [Integer] a macro ID
      #   @option options [String]
      #   @example Updates information for macro 12345
      #     Assistly.update_macro(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/macros/update
      def update_macro(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = put("macros/#{id}",options)
        if response['success']
          return response['results']['macro']
        else
          return response
        end
      end
      
      # Deletes a single macro
      #
      #   @param id [Integer] a macro ID
      #   @example Deletes macro 12345
      #     Assistly.update_macro(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.assistly.com/docs/api/macros/update
      def delete_macro(id)
        response = delete("macros/#{id}")
        response
      end
    end
  end
end
