module Desk
  class Client
    module Insight

      def insights_show_meta
        get("insights/meta")
      end
      alias_method :insights_meta, :insights_show_meta

      def insights_create_report(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        post("insights/reports", options)
      end

    end
  end
end
