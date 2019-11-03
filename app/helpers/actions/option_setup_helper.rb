# frozen_string_literal: true

module Helpers
  module Actions
    module OptionSetupHelper
      private

      def option_send_and_get_valid_response(option_name:, only_get_response: false, markup: nil)
        reset_user_tapped_message
        send_student_option_message(option_name, user, markup) unless only_get_response
        response = get_response_of_type('message')

        # TODO: add checks for validity of every option (check at databases)
        # throw error if check failed
        # @validity_checker = Services::StudentOptionValidityChecker.new(option_name) if validity_checker.option_name != option_name
        # @validity_checker.check(response)
        raise 'Not valid' if response == 'test'
        response

      rescue => _error
        send_message(text: I18n.t(option_name, scope: 'errors.student_settings.not_valid_input'))
        option_send_and_get_valid_response(option_name: option_name, only_get_response: true, markup: nil)
      end
    end
  end
end
