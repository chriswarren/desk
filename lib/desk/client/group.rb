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
      def groups(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("groups",options)
        response
      end

      # Returns extended information on a single group
      #
      #   @param id [Integer] a group ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Desk.group(12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/groups/show
      def group(id)
        response = get("groups/#{id}")
        response.group
      end

    end
  end
end