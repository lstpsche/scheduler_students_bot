# frozen_string_literal: true

class Schedule < ActiveRecord::Base
  has_many :schedule_users, dependent: :destroy
  has_many :users, through: :schedule_users
  has_many :events

  scope :matching_student, ->(user) do
    student_settings = user.student_settings
    result = where(
      university: student_settings.university,
      faculty: student_settings.faculty,
      course: student_settings.course
    )
    result = result.where(department: student_settings.department) if student_settings.department.present?
    result = result.where(group: student_settings.group) if student_settings.group.present?
    result
  end
  scope :available_for, ->(user) { matching_student(user).reject { |schedule| schedule.user_ids.include?(user.id) } }
  scope :for_student, -> { where(for_student: true) }
  scope :customed, -> { where(customed: true) }
  scope :not_customed, -> { where(customed: false) }

  def author
    schedule_users.find_by(author: true)&.user
  end
end
