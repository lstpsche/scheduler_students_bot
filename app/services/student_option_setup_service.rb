# frozen_string_literal: true

module Services
  class StudentOptionSetupService < Base
    include Helpers::Services::OptionSetupHelper
    include Helpers::Services::StudentOptionsSetupHelper

    # attrs from base -- :bot, :chat_id, :talker, :user
    attr_reader :response, :settings

    # 'initialize' is in base
    def initialize(bot:, user:)
      super do
        @settings = user.student_settings
      end
    end

    def setup_all
      setup_required_fields
      setup_optional_fields
      show_something_wrong unless settings.save
    end

    def setup_option(option_name)
      new_option_value = option_send_and_get_valid_response(option_name: option_name)

      saved = option_name_not_changed?(option_name) || settings.update("#{option_name}": new_option_value)

      if saved
        show_option_successfully_setup
      else
        show_something_wrong
      end
    end

    private

    def option_name_not_changed?(option_name)
      user.student_settings&.try(option_name) == new_option_value
    end
  end
end
