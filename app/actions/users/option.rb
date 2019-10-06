# frozen_string_literal: true

module Actions
  module Users
    class Option < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :option, :response

      # 'initialize' is in base

      def show(given_option_name)
        params = {
          before: { option: given_option_name },
          markup_options: Constants.option_options
        }

        super(params)
      end

      def back
        show_preferences
      end

      private

      def before_show(params = {})
        @option = Constants.preferences_options.select { |opt| opt[:name] == params[:option] }.first
      end

      def after_show(*args)
        set_replace_last_true
      end

      def callback(command)
        Constants.option_callback % {
          command: "#{command}_#{option_name(option)}",
          return_to: nil
        }
      end

      # 'create_button' is in base
      # 'create_markup' is in base
      # 'option_button' is in base
      # 'option_name' is in base

      def message_text
        user_option_text = user_option_text(option_name(option))

        "*#{option_button(option)}*\n#{user_option_text}"
      end
    end
  end
end
