# frozen_string_literal: true

module Routers
  module Messages
    class CallbacksRouter < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :params, :tapped_message

      HANDLERS = {
        'add_schedule' => Handlers::Callbacks::AddSchedule,
        'menu' => Handlers::Callbacks::Menu,
        'options' => Handlers::Callbacks::Options,
        'preferences' => Handlers::Callbacks::Preferences,
        'schedule' => Handlers::Callbacks::Schedule,
        'schedules' => Handlers::Callbacks::AllSchedules
      }

      def initialize(bot:)
        super do
          @params = {}
        end
      end

      def route(callback)
        init_vars(callback)

        update_user_tapped_message
        call_handler
      end

      private

      def call_handler
        HANDLERS[params[:handler_class]].new(bot: bot, user: user).handle(params[:command])
      end

      def init_vars(callback)
        @user_id = callback.from.id
        @tapped_message = callback.message
        @chat_id = callback.from.id
        @user = get_user(chat_id: chat_id)
        parse_callback(callback.data)
      end

      def parse_callback(command)
        # /^(\w+)-(\w+)?$/
        parsed_command = command.match(Constants.context_command_regex)

        params[:handler_class] = parsed_command[1]
        params[:command] = parsed_command[2]
      end

      def update_user_tapped_message
        user.update(tapped_message: tapped_message)
      end
    end
  end
end
