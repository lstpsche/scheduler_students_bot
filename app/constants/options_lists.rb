# frozen_string_literal: true

module Constants
  # :reek:TooManyConstants:
  module OptionsLists
    def in_schedule_options_list
      %i[
        hide
        pin
        settings
      ]
    end

    def menu_options_list
      %i[
        all_schedules
        preferences
      ]
    end

    def option_options_list
      %i[
        change_option
      ]
    end

    def user_preferences_options_list
      %i[]
    end

    def student_preferences_options_list
      %i[
        university
        faculty
        course
        department
        group
      ]
    end

    def schedule_options_list
      %i[
        show
        settings
      ]
    end

    def schedule_setting_options_list
      %i[
        change_setting
      ]
    end

    def schedule_settings_list
      %i[
        private
      ]
    end
  end
end
