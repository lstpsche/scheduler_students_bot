# frozen_string_literal: true

class StudentSettings < ActiveRecord::Base
  belongs_to :user

  class << self
    def registered?(user_id:)
      find_by(user_id: user_id).present?
    end
  end
end
