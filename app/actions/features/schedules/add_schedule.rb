# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class AddSchedule < Base
        # attrs from base -- :bot, :chat_id, :user
        attr_reader :schedules

        def initialize(bot:, user:)
          super
          @schedules = ::Schedule.available_for(user)
        end

        # 'show' is in base

        private

        def callback(schedule_id)
          Constants.add_schedule_callback % { schedule_id: schedule_id }
        end

        def create_markup
          super(schedules)
        end

        def message_text
          I18n.t('actions.features.schedules.add_schedule.header')
        end

        def option_button(schedule)
          schedule.name
        end

        def option_name(schedule)
          schedule.id
        end
      end
    end
  end
end
