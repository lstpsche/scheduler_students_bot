# frozen_string_literal: true

module Actions
  module Users
    class Registration < Actions::Users::Base
      # attrs from base -- :bot, :chat_id, :user, :params
      attr_reader :student_settings

      def initialize(bot:, tg_user:)
        super(bot: bot, user: create_user(tg_user))
        @student_settings = DB.create_student_settings(user: user)
      end

      # 'show' is in base

      private

      def create_user(tg_user)
        User.find_by(id: tg_user.id) || DB.create_user(tg_user: tg_user)
      end

      def after_show
        setup_student_settings
        show_add_schedule(no_back: true)
      end

      def message_text
        I18n.t('actions.users.registration.welcome', name: user.first_name)
      end
    end
  end
end
