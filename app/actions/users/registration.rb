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

      # 'show' is in base

      private

      def before_show(*_args)
        @user = user_registered?(id: chat_id) ? User.find_by(id: chat_id) : DB.create_user(tg_user: tg_user)
        @student_settings = DB.create_student_settings(user: user)
        reset_user_tapped_message
      end

      def after_show(*_args)
        setup_student_settings
        show_add_schedule(no_back: true, message_text: I18n.t('actions.users.registration.available_schedules'))
      end

      def create_markup(*_args)
        nil
      end

      def message_text
        I18n.t('actions.users.registration.welcome', name: user.first_name)
      end
    end
  end
end
