# frozen_string_literal: true

class Schedule < ActiveRecord::Base
  has_many :schedule_users, dependent: :destroy
  has_many :users, through: :schedule_users
  has_many :events, dependent: :destroy

  scope :matching_student, (lambda do |user|
    student_settings = user.student_settings
    result = where(
      university: student_settings.university,
      faculty: student_settings.faculty,
      course: student_settings.course
    )
    result = result.where(department: student_settings.department) if student_settings.department.present?
    result = result.where(group: student_settings.group) if student_settings.group.present?
    result
  end)
  # TODO: only public schedules should be returned here
  scope :available_for, (lambda do |user|
    public_ones.matching_student(user).reject { |schedule| schedule.user_ids.include?(user.id) }
  end)
  scope :customed, -> { where(customed: true) }
  scope :for_student, -> { where(for_student: true) }
  scope :not_customed, -> { where(customed: false) }
  scope :private_ones, -> { where(private: true) }
  scope :public_ones, -> { where(private: false) }

  def author
    users.where('schedule_users.author = true').take
  end

  def decorated
    DecoratedSchedule.find_by(id: id)
  end

  def order_by_time(events)
    events.sort_by { |event| event.time.to_datetime }
  end

  def order_by_weekday(events)
    events.sort_by { |event| Constant.weekdays.index(event.weekday) }
  end
end

class DecoratedSchedule < Schedule
  def view
    title + decorated_events
  end

  def title
    I18n.t('layouts.schedule.title',
           schedule_name: name,
           schedule_id: id,
           schedule_additional_info: decorated_additional_info
          )
  end

  private

  def decorated_additional_info
    additional_info + "\n"
  end

  def decorated_events
    events_hashed_by_weekday.inject('') do |text, (weekday, events)|
      text + decorated_weekday(weekday, events)
    end
  end

  def decorated_weekday(weekday, events)
    header_weekday = I18n.t('layouts.schedule.events.weekday', weekday: weekday.capitalize)
    weekday_events = events.map(&:decorated_view).inject(&:+)

    header_weekday + weekday_events + "\n"
  end

  def events_hashed_by_weekday
    order_by_weekday(order_by_time(events)).each_with_object({}) do |event, result|
      weekday = event.weekday
      result[weekday] = (Array.wrap(result[weekday]) << event)
    end
  end
end
