# frozen_string_literal: true

module Helpers
  module Talker
    module Actions
      include Helpers::Talker::CommonActions
      include Helpers::Talker::Errors

      private

      #################### Setups ####################################

      def talker(bot = @bot, chat_id = @chat_id, _user = @user)
        ::Talker.new(bot: bot, chat_id: chat_id, user: get_user(chat_id: chat_id))
      end

      ############## Sending--Editing--Getting #######################

      # move this to StudentOptionSetupService
      def send_student_option_message(option_name, user, markup = nil)
        message_text = I18n.t("actions.users.student_settings.#{option_name}.text")
        send_or_edit_message(
          message_id: user.tapped_message_id, text: message_text,
          markup: markup
        )
      end

      ##################### Other ####################################

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

      def show_help
        talker.show_help
      end
    end
  end
end
