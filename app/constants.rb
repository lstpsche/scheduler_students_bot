# frozen_string_literal: true

class Constants
  class << self
    # REGEXES
    def command_regex
      /^\/(\w+)$/
    end

    def context_command_regex
      /^(\w+)-(\w+)(-(\w+))?$/
    end

    def set_schedule_name_full_layout
      /(.+)--(.+)/
    end

    def set_schedule_name_layout_without_add_info
      /(.+)/
    end

    # TODO: remove whitespaces around --
    def day_event_full_layout
      /^(\d+:\d+) (.+) -- (.+)$/
    end

    def day_event_layout_without_add_info
      /^(\d+:\d+) (.+)$/
    end

    def event_in_schedule_decoration
      "*%{time}*: %{info} _(%{additional_info})_"
    end

    # OPTIONS

    def in_schedule_options
      scope = 'actions.features.schedules.schedule.options'

      options_translations_for(IN_SCHEDULE_OPTIONS, scope)
    end

    def option_options
      scope = 'actions.users.option'

      options_translations_for(OPTION_OPTIONS, scope)
    end

    def preferences_options
      student_scope = 'actions.users.student_settings'
      scope = 'actions.users.options'

      options_translations_for(STUDENT_PREFERENCES_OPTIONS, student_scope) +
        options_translations_for(USER_PREFERENCES_OPTIONS, scope)
    end

    def schedule_options
      scope = 'actions.features.schedules.schedule.options'

      options_translations_for(SCHEDULE_OPTIONS, scope)
    end

    def menu_options
      scope = 'actions.features.menu'

      options_translations_for(MENU_OPTIONS, scope)
    end

    # CALLBACKS

    def main_menu_callback
      "menu-%{command}%{return_to}"
    end

    def all_schedules_callback
      "schedules-%{command}%{return_to}"
    end

    def option_callback
      "options-%{command}%{return_to}"
    end

    def preferences_callback
      "preferences-show_%{command}"
    end

    def schedule_callback
      # command MUST be like "#{schedule_id}__#{action}
      "schedule-%{command}%{return_to}"
    end

    # using for inner coding. no need to translate

    def text_commands
      [
        '/start',
        '/menu',
        '/help'
      ]
    end

    def weekdays
      [
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
        'sunday'
      ]
    end

    def translated_weekdays
      weekdays.map do |weekday|
        I18n.t(weekday, scope: 'weekdays')
      end
    end

    private

    def options_translations_for(options, scope)
      # returns hash: { name: '.....', text: '....' }
      options.map do |option|
        I18n.t(option, scope: scope)
      end
    end

    # OPTIONS LISTS

    IN_SCHEDULE_OPTIONS = [
      :hide,
      :pin,
      :back
    ]

    MENU_OPTIONS = [
      :all_schedules,
      :preferences
    ]

    OPTION_OPTIONS = [
      :change_option,
      :back
    ]

    USER_PREFERENCES_OPTIONS = [
      # TODO: add here something maybe
      :back
    ]

    STUDENT_PREFERENCES_OPTIONS = [
      :university,
      :faculty,
      :course,
      :department,
      :group
    ]

    SCHEDULE_OPTIONS = [
      :show,
      :back
    ]
  end
end
