# frozen_string_literal: true

module Services
  class TextCommandValidationService < Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :command, :errors

    def initialize(bot:, chat_id:, command:)
      @bot = bot
      @chat_id = chat_id
      @command = command
      @errors = []
    end

    def success?
      validate
    end

    def failure?
      !success?
    end

    private

    def validate
      return bad_message unless message_valid?
      return not_understand unless command_syntax_valid?
      return no_command unless command_exists?
      return not_registered if registration_needed?

      true
    end

    def message_valid?
      command.present?
    end

    def command_syntax_valid?
      command.match(Constant.command_regex)
    end

    def command_exists?
      Constant.text_commands.include? command
    end

    def registration_needed?
      command != '/start' && !user_registered?(id: chat_id)
    end

    def bad_message
      errors << '400: Bad input'
      false
    end

    def not_understand
      errors << '400: Not understand'
      false
    end

    def no_command
      errors << '501: No command'
      false
    end

    def not_registered
      errors << '401: Not registered'
      false
    end
  end
end
