# frozen_string_literal: true

module Handlers
  module Callbacks
    class AddSchedule < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :schedule

      # 'initialize' is in base

      def handle(schedule_id)
        @schedule = ::Schedule.find_by(id: schedule_id)

        check_schedule_validity
        add_schedule_to_user
        show_all_schedules
      end

      private

      def add_schedule_to_user
        Services::Schedules::AddScheduleToUserService.new(bot: bot, user: user, schedule: schedule).perform
      end

      def check_schedule_validity
        raise 'Invalid schedule_id' unless schedule.present?
      end
    end
  end
end
