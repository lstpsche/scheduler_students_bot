# frozen_string_literal: true

module Actions
  module Features
    class Base
      include Helpers::Common
      include Helpers::TalkerActions
      include Helpers::MenusActions

      attr_reader :bot, :chat_id, :user

      def initialize(bot:, user:)
        @bot = bot
        @user = user
        @chat_id = user.id
        # TODO: REMOVE ALL THOSE UNNEEDED YIELDS
        yield if block_given?
      end

      # TODO: refactor this 'show' (AND ALL OTHERS NOT REFACTORED 'show's)
      # to be with params
      def show
        markup = create_markup
        text = message_text

        send_or_edit_message(message_id: user.last_message_id, text: text, markup: markup)
        set_replace_last_true
      end

      def back
        # TODO: refactor ALL CODE -- setting of replace last should be ONLY AFTER ACTION
        set_replace_last_true
        show_main_menu
      end

      private

      def callback(command)
        command
      end

      def create_button(text, command)
        Telegram::Bot::Types::InlineKeyboardButton.new(
          text: text,
          callback_data: callback(command)
        )
      end

      def create_markup(options = [])
        kb = []
        options.each do |option|
          kb << create_button(option_button(option), option_name(option))
        end
        kb += Array.wrap(yield) if block_given?

        Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      end

      # TODO: rename ALL 'option_button' to 'option_text' THROUGH ALL THE CODE
      def option_button(option)
        option[:button]
      end

      def option_name(option)
        option[:name]
      end
    end
  end
end
