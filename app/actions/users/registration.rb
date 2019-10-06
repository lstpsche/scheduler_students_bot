# frozen_string_literal: true

module Actions
  module Users
    class Registration < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :tg_user, :student_settings

      def initialize(bot:, tg_user:)
        @bot = bot
        @tg_user = tg_user
        @chat_id = tg_user.id
      end

      def show
        if user_registered?(id: chat_id)
          @user = User.find_by(id: chat_id)
        else
          @user = DB.create_user(tg_user: tg_user)
        end

        @student_settings = DB.create_student_settings(user: user)

        send_message(text: message_text)

        setup_student_settings
        # TODO: replace this menu showing with "Add schedule" menu
        show_main_menu
      end

      # Registration has no 'back' button
      def back
        raise NoMethodError
      end

      private

      def message_text
        I18n.t('actions.users.registration.welcome') % { name: user.first_name }
      end
    end
  end
end
