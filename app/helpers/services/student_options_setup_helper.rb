# frozen_string_literal: true

module Helpers
  module Services
    module StudentOptionsSetupHelper
      private

      def setup_required_fields
        settings.university = option_send_and_get_valid_response(option_name: 'university')
        settings.faculty = option_send_and_get_valid_response(option_name: 'faculty')
        settings.course = option_send_and_get_valid_response(option_name: 'course')
      end

      def setup_optional_fields
        if settings.course.to_i > 2
          settings.department = option_send_and_get_valid_response(option_name: 'department')
        else
          settings.group = option_send_and_get_valid_response(option_name: 'group')
        end
      end
    end
  end
end
