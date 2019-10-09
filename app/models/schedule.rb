# frozen_string_literal: true

class Schedule < ActiveRecord::Base
  has_many :schedule_users
  has_many :users, through: :schedule_users
  has_many :events

  # TODO: fill this scope
  scope :available_for, ->(user) { all }
end
