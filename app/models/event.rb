# frozen_string_literal: true

class Event < ActiveRecord::Base
  # TODO: add weekday validation

  def decorated_view
    I18n.t('layouts.schedule.events.event',
           time: time,
           info: info,
           additional_info: decorated_additional_info
          )
  end

  private

  def decorated_additional_info
    additional_info.present? ? "(#{additional_info})" : nil
  end
end
