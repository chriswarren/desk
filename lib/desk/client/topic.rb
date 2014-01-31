module Desk
  class Client
    module Topic

      def topic_endpoints
        [ :list, :show, :create, :update, :delete,
          :list_translations, :show_translation, :create_translation,
          :update_translation, :delete_translation ]
      end

    end
  end
end
