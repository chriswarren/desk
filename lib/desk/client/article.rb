module Desk
  class Client
    module Article

      def article_endpoints
        [ :list, :show, :create, :update, :delete, :search,
          :list_translations, :show_translation, :create_translation,
          :update_translation, :delete_translation ]
      end

    end
  end
end
