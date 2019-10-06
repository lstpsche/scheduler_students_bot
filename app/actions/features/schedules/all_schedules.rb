# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class AllSchedules < Base
        # attrs from base -- :bot, :chat_id, :user

        # 'initialize' is in base
        # 'show' method is in base
        # 'back' method is in base

        private

        # command here is schedule_id
        def callback(command)
          Constants.all_schedules_callback % {
            command: command,
            return_to: nil
          }
        end

        # create_button is in base

        def create_markup
          super(user.schedules) do
            add_text = I18n.t('actions.features.schedules.all_schedules.add_schedule.button')
            add_callback = I18n.t('actions.features.schedules.all_schedules.add_schedule.name')
            back_text = I18n.t('actions.features.schedules.all_schedules.back.button')
            back_callback = I18n.t('actions.features.schedules.all_schedules.back.name')

            [
              create_button(add_text, add_callback),
              create_button(back_text, back_callback)
            ]
          end
        end

        def message_text
          I18n.t('actions.features.schedules.all_schedules.header')
        end

        # here option, which will be passed, is one of user's schedule
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
