# frozen_string_literal: true

class User < ActiveRecord::Base
  serialize :context, ::Serializers::HashSerializer
  store_accessor :context, :last_message, :replace_last_message, :tapped_message
  has_one :student_settings, dependent: :destroy
  has_many :schedule_users, dependent: :destroy
  has_many :schedules, through: :schedule_users

  def empty_context
    {
      'last_message' => {
        'result' => {
          'message_id' => nil
        }
      },
      'replace_last_message' => false,
      'tapped_message' => nil
    }
  end

  def context
    super.empty? ? empty_context : super
  end

  def last_message
    context['last_message']
  end

  def replace_last_message?
    context['replace_last_message']
  end

  def tapped_message
    context['tapped_message'] || {}
  end

  def tapped_message=(msg)
    context['tapped_message'] = msg
  end

  def tapped_message_id
    tapped_message['message_id']
  end

  def student?
    student_settings.present?
  end

  class << self
    def registered?(id:)
      find_by(id: id).present?
    end
  end
end
