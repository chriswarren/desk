module Desk
  class Client
    # Defines methods related to groups
    module Group
      # Returns extended information of groups
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Desk.groups
      #     Desk.groups(:count => 5)
      #     Desk.groups(:count => 5, :page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/groups
      def list_groups(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("groups", options)
      end
      alias_method :groups, :list_groups

      # Returns extended information on a single group
      #
      #   @param id [Integer] a group ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Desk.group(12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/groups/show
      def show_group(group_id)
        get("groups/#{group_id}")
      end
      alias_method :group, :show_group

      def list_group_filters(group_id)
        get("groups/#{group_id}/filters")
      end
      alias_method :group_filters, :list_group_filters

      def list_group_users(group_id)
        get("groups/#{group_id}/users")
      end
      alias_method :group_users, :list_group_users

    end
  end
end
