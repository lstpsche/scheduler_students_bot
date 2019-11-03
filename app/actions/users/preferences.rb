# frozen_string_literal: true

module Actions
  module Users
    class Preferences < Base
      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base

      def show
        params = {
          markup_options: Constants.preferences_options
        }

        super(params)
      end

      def back
        show_main_menu
      end

      private

      def callback(option_name)
        Constants.preferences_callback % { option_name: option_name }
      end

      def message_text
        I18n.t('actions.users.preferences.show_options')
      end
    end
  end
end
