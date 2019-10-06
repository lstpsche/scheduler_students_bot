# frozen_string_literal: true

class StudentSettings < ActiveRecord::Base
  belongs_to :user
end
