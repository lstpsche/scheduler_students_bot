# frozen_string_literal: true

module Services
  class StudentOptionSetupService < Base
    include Helpers::Actions::OptionSetupHelper

    # attrs from base -- :bot, :chat_id, :talker, :user
    attr_reader :response, :settings

    # 'initialize' is in base
    def initialize(bot:, user:)
      super do
        @settings = user.student_settings
      end
    end

    def setup_all
      settings.university = option_send_and_get_valid_response(option_name: 'university')
      settings.faculty = option_send_and_get_valid_response(option_name: 'faculty')
      settings.course = option_send_and_get_valid_response(option_name: 'course')
      if settings.course.to_i > 2
        settings.department = option_send_and_get_valid_response(option_name: 'department')
      else
        settings.group = option_send_and_get_valid_response(option_name: 'group')
      end

      show_something_wrong unless settings.save
    end

    def setup_option(option_name)
      new_option_value = option_send_and_get_valid_response(option_name: option_name)

      saved = if user.send("#{option_name}") == new_option_value
                true
              else
                settings.update("#{option_name}": new_option_value)
              end

      if saved
        show_option_successfully_setup
      else
        show_something_wrong
      end
    end
  end
end
