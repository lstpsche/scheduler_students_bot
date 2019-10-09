# frozen_string_literal: true

module Services
  module Schedules
    class AddScheduleToUserService < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :schedule

      def initialize(bot:, user:, schedule_id:)
        super(bot: bot, user: user)
        @schedule = Schedule.find_by(id: schedule_id)
      end

      def perform
        user.schedules << schedule
        user.save
      end
    end
  end
end
