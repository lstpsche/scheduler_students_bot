# frozen_string_literal: true

module Actions
  module Users
    class Preferences < Actions::Users::Base
      # attrs from base -- :bot, :chat_id, :user, :params

      # 'initialize' is in base

      def show
        @params = Params.new(
          markup_options: Constant.preferences_options
        )

        super
      end

      def back
        show_main_menu
      end

      private

      def callback
        Constant.preferences_callback
      end

      def message_text
        Decorators::MenuDecorator.decorate(
          { menu: 'preferences' },
          I18n.t('actions.users.preferences.show_options')
        )
      end
    end
  end
end
