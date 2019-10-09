# frozen_string_literal: true

class Schedule < ActiveRecord::Base
  has_many :schedule_users
  has_many :users, through: :schedule_users
  has_many :events

  # TODO: fill this scope
  scope :matching_student, ->(user) { all }
  scope :available_for, ->(user) { matching_student(user).where.not(author_id: user.id) }
  scope :custom, -> { where(custom: true) }
  scope :not_custom, -> { where(custom: false) }

  def author
    User.find_by(id: author_id)
  end

  def customed_author
    User.find_by(id: customed_by)
  end
end
