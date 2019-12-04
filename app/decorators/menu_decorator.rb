# frozen_string_literal: true

module Decorators
  class MenuDecorator < Base
    CONTEXT_TITLE = {
      'add_schedule': Schedules::AddSchedule,
      'all_schedules': Schedules::AllSchedules
    }.with_indifferent_access

    # 'initialize' is in base

    def self.decorate(context, text = '')
      new(context, text).full_view
    end

    def full_view
      context_class.decoration_parts.join("\n")
    end

    private

    def context_class
      @context_class ||= CONTEXT_TITLE[@context[:menu]].new(@context, @text)
    end
  end
end