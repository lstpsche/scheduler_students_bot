# frozen_string_literal: true

module Routers
  module Messages
    class TextCommandsRouter < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :command, :tg_user

      HANDLERS = {
        'start' => Handlers::TextCommands::StartHandler,
        'menu' => Handlers::TextCommands::MenuHandler,
        'help' => Handlers::TextCommands::HelpHandler
      }.freeze

      # 'initialize' is in base

      def route(message)
        init_vars(message)
        raise validation_service.errors.first if validation_service.failure?

        actual_command = command.split('/').last
        call_handler_with(actual_command)
      end

      private

      def init_vars(message)
        @command = message.text
        @tg_user = message.from
        @user = get_user(chat_id: tg_user.id)
        @chat_id = user.id
        reset_user_tapped_message if user.tapped_message.present?
      end

      def validation_service
        @validation_service ||= Services::TextCommandValidationService.new(bot: bot, chat_id: chat_id, command: command)
      end

      def call_handler_with(actual_command)
        HANDLERS[actual_command].new(bot: bot, chat_id: chat_id, user: user || tg_user).handle
      end
    end
  end
end
