# frozen_string_literal: true

module Services
  class StudentOptionSetupService < Base
    include Helpers::Actions::UsersHelper
    include Helpers::Actions::OptionsSetups

    # attrs from base -- :bot, :chat_id, :talker, :user
    attr_reader :response, :settings

    # 'initialize' is in base
    def initialize(bot:, user:)
      super do
        @settings = user.student_settings
      end
    end

    def setup_all
      # TODO: Add validations for all fields
      # TODO: Add errors handling
      settings.university = option_send_and_get_response(option_name: 'university')
      settings.faculty = option_send_and_get_response(option_name: 'faculty')
      settings.course = option_send_and_get_response(option_name: 'course')
      if settings.course.to_i > 2
        settings.department = option_send_and_get_response(option_name: 'department')
      else
        settings.group = option_send_and_get_response(option_name: 'group')
      end

      if settings.save
      else
        show_something_wrong
      end
    end

    # TODO: REFACTOR THIS METHOD
    def setup_option(option_name)
      # not using this
      message_text = user_option_text(option_name)

      settings.send("#{option_name}=", option_send_and_get_response(option_name: option_name))
      if settings.save
        show_option_successfully_setup
      else
        show_something_wrong
      end
    end

    private

    def option_send_and_get_response(option_name:, markup: nil)
      set_replace_last_false
      send_student_option_message(option_name, user, markup)
      get_response
    end
  end
end
