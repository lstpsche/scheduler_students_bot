# frozen_string_literal: true

module Helpers
  module Services
    module OptionSetupHelper
      private

      def option_send_and_get_valid_response(option_name:, only_receive_response: false)
        reset_user_tapped_message
        send_student_option_message(option_name, user) unless only_receive_response
        receive_valid_response
      rescue StandardError => _error
        rescue_from_invalid_option_input(option_name: option_name)
      end

      def receive_valid_response
        response = receive_response_of_type('message')

        # TODO: add checks for validity of every option (check at databases)
        # throw error if check failed
        # if validity_checker.option_name != option_name
        #   @validity_checker = Services::StudentOptionValidityChecker.new(option_name)
        # end
        # @validity_checker.check(response)
        raise 'Not valid' if response == 'test'

        response
      end

      def rescue_from_invalid_option_input(option_name:)
        send_message(text: I18n.t(option_name, scope: 'errors.student_settings.not_valid_input'))
        option_send_and_get_valid_response(option_name: option_name, only_receive_response: true)
      end
    end
  end
end
