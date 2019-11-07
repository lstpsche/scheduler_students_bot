# frozen_string_literal: true

module Constants
  # :reek:TooManyConstants:
  module OptionsLists
    IN_SCHEDULE_OPTIONS = %i[
      hide
      pin
      back
    ].freeze

    MENU_OPTIONS = %i[
      all_schedules
      preferences
    ].freeze

    OPTION_OPTIONS = %i[
      change_option
      back
    ].freeze

    USER_PREFERENCES_OPTIONS = %i[
      back
    ].freeze

    STUDENT_PREFERENCES_OPTIONS = %i[
      university
      faculty
      course
      department
      group
    ].freeze

    SCHEDULE_OPTIONS = %i[
      show
      back
    ].freeze
  end
end
