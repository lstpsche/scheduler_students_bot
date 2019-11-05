# frozen_string_literal: true

module Helpers
  module Common
    private

    def get_user(user = nil, chat_id: nil, fallback_user: nil)
      @user || user || User.find_by(id: chat_id) || fallback_user
    end

    def message_data_from(message)
      case message
      when Telegram::Bot::Types::Message
        return message.text
      when Telegram::Bot::Types::CallbackQuery
        return message.data
      end
    end

    def reset_user_tapped_message
      user&.update(tapped_message: nil)
    end

    def student_registered?(id:)
      StudentSettings.registered?(user_id: id)
    end

    def user_option(option_name)
      user&.send(option_name) || user.student_settings&.send(option_name)
    end

    def user_option_text(option_name)
      if option.present?
        I18n.t('actions.users.option.user_option_text.present', option_value: user_option(option_name))
      else
        I18n.t('actions.users.option.user_option_text.not_present')
      end
    end

    def user_registered?(id:)
      User.registered?(id: id)
    end
  end
end
