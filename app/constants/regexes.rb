# frozen_string_literal: true

module Constants
  module Regexes
    def command_regex
      /^\/(\w+)$/
    end

    def context_command_regex
      /^(\w+)-(\w+)?$/
    end

    def event_in_schedule_decoration
      '*%{time}*: %{info} _(%{additional_info})_'
    end
  end
end
