# frozen_string_literal: true

module Services
  module Schedules
    class ScheduleUserInteraction < Base
      # attrs from base -- :bot, :chat_id, :user
      attr_reader :schedule

      def initialize(bot:, user:, schedule: nil)
        super(bot: bot, user: user)
        @schedule = schedule
      end

      def perform
        user.schedules << schedule
        user.save
      end

      # TODO: DO NOT KNOW YET WHERE WILL USE THIS
      # MAYBE THIS WILL BE AT WEB VERSION
      # well, yes, this should be at web ver.
      def edit_schedule
        user.schedules.where(id: schedule.id).first = schedule.clone.update(custom: true, customed_by: user.id)
        user.save
      end

      def create_new
        send_message(text: 'There will be a link for creating of a new schedule at web-version.')
      end
    end
  end
end
