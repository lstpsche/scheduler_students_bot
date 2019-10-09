# frozen_string_literal: true

module Handlers
  module Callbacks
    class AddSchedule < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :schedule_id

      # 'initialize' is in base

      def handle(schedule_id)
        @schedule_id = schedule_id

        check_schedule_id_validity
        add_schedule_to_user
        show_all_schedules
      end

      private

      def add_schedule_to_user
        Services::Schedules::AddScheduleToUserService.new(bot: bot, user: user, schedule_id: schedule_id).perform
      end

      def check_schedule_id_validity
        # TODO: FILL THIS METHOD
        # return errors (I hope they will be catched)
      end
    end
  end
end
