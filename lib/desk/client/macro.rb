module Desk
  class Client
    # Defines methods related to macros
    module Macro
      # Returns extended information of macros
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Desk.macros
      #     Desk.macros(:count => 5)
      #     Desk.macros(:count => 5, :page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros
      def list_macros(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("macros", options)
      end
      alias_method :macros, :list_macros

      # Returns extended information on a single macro
      #
      #   @param id [Integer] a macro ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Desk.macro(12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/show
      def show_macro(macro_id)
        get("macros/#{macro_id}")
      end
      alias_method :macro, :show_macro

      # Creates a new macro
      #
      #   @param name [String] A macro name
      #   @option options [Hash]
      #   @example Creates a new macro
      #     Desk.create_macro("name")
      #     Desk.create_macro("name")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/create
      def create_macro(name, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        post("macros", options)
      end

      # Updates a single macro
      #
      #   @param id [Integer] a macro ID
      #   @option options [String]
      #   @example Updates information for macro 12345
      #     Desk.update_macro(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/update
      def update_macro(macro_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        patch("macros/#{macro_id}", options)
      end

      # Deletes a single macro
      #
      #   @param id [Integer] a macro ID
      #   @example Deletes macro 12345
      #     Desk.update_macro(12345, :subject => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/update
      def delete_macro(macro_id)
        delete("macros/#{macro_id}")
      end

      ##########
      # Macro Actions
      ##########

      # Returns extended information of macros
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Desk.macro_actions(1)
      #     Desk.macro_actions(1, :count => 5)
      #     Desk.macro_actions(1, :count => 5, :page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/actions
      def list_macro_actions(macro_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("macros/#{macro_id}/actions", options)
      end
      alias_method :macro_actions, :list_macro_actions

      # Returns extended information on a single macro
      #
      #   @param id [Integer] a macro ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Desk.macro_action(12345, "set-case-description")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/actions/show
      def show_macro_action(macro_id, action_id)
        get("macros/#{macro_id}/actions/#{action_id}")
      end
      alias_method :macro_action, :show_macro_action

      # Updates a single macro action
      #
      #   @param id [Integer] a macro ID
      #   @option options [String]
      #   @example Updates information for macro 12345
      #     Desk.update_macro_action(12345, "set-case-description", :value => "New Subject")
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/macros/actions/update
      def update_macro_action(macro_id, action_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        patch("macros/#{macro_id}/actions/#{action_id}", options)
      end

    end
  end
end
