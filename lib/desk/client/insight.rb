module Desk
  class Client
    module Insight

      def show_insights_meta
        get("insights/meta")
      end
      alias_method :insights_meta, :show_insights_meta

      def create_insights_report(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        post("insights/reports", options)
      end

    end
  end
end
