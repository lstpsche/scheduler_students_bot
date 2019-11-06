# frozen_string_literal: true

module Services
  class ErrorParserService < Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :error

    ERRORS_METHODS = {
      4 => {
        'Bad input' => :show_bad_input,
        'Not understand' => :show_not_understand,
        'Not registered' => :show_not_registered
      },
      5 => {
        'No command' => :show_no_command,
        'Invalid schedule_id' => :show_invalid_schedule
      },
      other: :show_something_wrong
    }.freeze

    def initialize(bot:, chat_id:, error:)
      @bot = bot
      @chat_id = chat_id
      @error = error
    end

    def handle_errors
      code, desc = error.split(': ', 2)
      code_first_num = code.slice(0).to_i

      if ERRORS_METHODS.keys.include? code_first_num
        method(ERRORS_METHODS[code_first_num][desc]).call
      else
        show_something_wrong
      end
    end
  end
end
