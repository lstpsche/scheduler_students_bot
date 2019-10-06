# frozen_string_literal: true

module Helpers
  module Common
    def set_replace_last_true
      user&.update(replace_last_message: true)
    end

    def set_replace_last_false
      user&.update(replace_last_message: false)
    end

    def get_user(user = nil, chat_id: nil, fallback_user: nil)
      @user || user || User.find_by(id: chat_id) || fallback_user
    end

    def user_registered?(id:)
      User.registered?(id: id)
    end

    def student_registered?(id:)
      StudentSettings.registered?(user_id: id)
    end

    def user_option(option_name)
      user&.send(option_name) || user.student_settings&.send(option_name)
    end

    def user_option_text(option_name)
      option = user_option(option_name)

      if option.present?
        '_Current:_ ' + option
      else
        'This setting was not set for you yet.'
      end
    end
  end
end
