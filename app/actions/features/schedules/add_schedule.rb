# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class AddSchedule < Actions::Features::Schedules::Base
        # attrs from base -- :bot, :chat_id, :user, :params
        attr_reader :schedules

        def initialize(bot:, user:, **params)
          super(bot: bot, user: user)
          @no_back = params[:no_back]
          @schedules = ::Schedule.available_for(user)
        end

        def show
          @params = Params.new(
            markup_options: schedules
          )

          super
        end

        private

        def callback
          Constant.add_schedule_callback
        end

        def create_markup
          super do
            [
              create_schedule_button,
              back_button
            ].compact
          end
        end

        def create_schedule_button
          create_schedule = I18n.t('actions.features.schedules.add_schedule.create_new')
          Button.new(button_args(create_schedule)).inline
        end

        def back_button
          return nil if @no_back

          back = I18n.t('actions.features.schedules.add_schedule.back')
          Button.new(button_args(back)).inline
        end

        def message_text
          @schedules.compact.present? ? schedules_present_message_text : no_schedules_message_text
        end

        def schedules_present_message_text
          I18n.t('actions.features.schedules.add_schedule.header')
        end

        def no_schedules_message_text
          I18n.t('actions.features.schedules.add_schedule.no_schedules_header')
        end

        def create_button_for_kb(schedule)
          super({}) do |button|
            button.update(schedule_options(schedule))
          end
        end

        # 'schedule_options' is in base
      end
    end
  end
end
