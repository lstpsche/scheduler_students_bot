# frozen_string_literal: true

module Actions
  module Features
    module Schedules
      class Base < Actions::Features::Base
        # Helpers::Common
        # Helpers::Talker::Actions
        # Helpers::Menus::Actions

        # attrs from base -- :bot, :chat_id, :user, :params

        # 'initialize' is in base
        # 'show' is in base
        # 'back' is in base

        # 'before_show' mock is in base
        # 'after_show' mock is in base

        # 'callback' is in base
        # 'create_button' is in base
        # 'create_markup' is in base
        # 'button_args' is in base

        private

        def find_schedule_by(id:)
          @schedule = ::Schedule.find_by(id: id)
        end

        def schedule_options(schedule)
          { text: schedule.name, name: schedule.id }
        end
      end
    end
  end
end
