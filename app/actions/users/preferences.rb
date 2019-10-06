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

      private

      def message_text
        I18n.t('actions.users.preferences.show_options')
      end

      def callback(command)
        Constants.preferences_callback % { command: command }
      end
    end
  end
end
