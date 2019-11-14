# frozen_string_literal: true

module Handlers
  class ErrorsHandler < Handlers::Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :error

    HANDLE_METHODS = {
      client: {
        'Bad input' => :show_bad_input,
        'Not understand' => :show_not_understand,
        'Not registered' => :show_not_registered
      },
      server: {
        'No command' => :show_no_command,
        'Invalid schedule_id' => :show_invalid_schedule
      }
    }.with_indifferent_access

    def initialize(bot:, chat_id:)
      @bot = bot
      @chat_id = chat_id
    end

    def handle(error:)
      @error = error
      if error_types.include?(error.type)
        call_handler(error)
      else
        show_something_wrong
      end
    end

    private

    def call_handler(error)
      method(handle_methods_for_error_type[error.message]).call
    end

    def error_types
      HANDLE_METHODS.keys
    end

    def handle_methods_for_error_type
      HANDLE_METHODS[error.type]
    end
  end
end
