# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class CreateSchedule < Base
        # attrs from base -- :bot, :chat_id, :user

        # 'initialize' is in base

        # 'show' is in base
        def show
          params = {
            markup_options: []
          }

          super(params)
        end

        private

        def create_button_with_url(text)
          Telegram::Bot::Types::InlineKeyboardButton.new(
            text: text,
            url: ENV['WEB_CREATE_SCHEDULE_URL']
          )
        end

        def create_markup(markup_options)
          super(markup_options) do
            create_button_with_url('Go to web version')
          end
        end

        def message_text
          I18n.t('actions.features.schedules.create_schedule.header')
        end
      end
    end
  end
end
