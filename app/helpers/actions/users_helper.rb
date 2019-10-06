# frozen_string_literal: true


# TODO: THIS HELPER SHOULD BE DEPRECATED
module Helpers
  module Actions
    module UsersHelper
      def get_response
        # THIS RESPONSE CAN BE FROM ANOTHER PERSON
        # SHOULD TEST IT AND MAYBE ADD CHECKER, IF RESPONSE IS FROM NEEDED USER
        @response = get_message

        case @response
        when Telegram::Bot::Types::Message
          return @response.text
        when Telegram::Bot::Types::CallbackQuery
          return @response.data
        end
      end

      def send_student_option_message(option_name, user, markup = nil)
        message_text = I18n.t("actions.users.student_settings.#{option_name}.text")
        send_or_edit_message(
          message_id: user.last_message_id, text: message_text,
          markup: markup
        )
      end

      def show_setup_successfull
        send_message(
          text: I18n.t('actions.users.preferences.setup_successful'),
          markup: 'remove'
        )
      end

      def show_option_successfully_setup
        send_message(
          text: I18n.t('actions.users.options.setup_successful'),
          markup: 'remove'
        )
      end
    end
  end
end
