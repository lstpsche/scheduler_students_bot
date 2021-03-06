# frozen_string_literal: true

class User < ActiveRecord::Base
  serialize :context, ::Serializers::HashSerializer
  store_accessor :context, :last_message, :replace_last_message, :tapped_message
  has_one :student_settings, dependent: :destroy
  has_many :schedule_users, dependent: :destroy
  has_many :schedules, through: :schedule_users

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
    context['tapped_message'] || empty_context['tapped_message']
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

  def student_option(option_name)
    student_settings&.try(option_name)
  end

  def create_auth_token
    authentication_token.presence || generate_new_auth_token
  end

  def self.registered?(id:)
    find_by(id: id).present?
  end

  private

  def generate_new_auth_token
    update(authentication_token: SecureRandom.urlsafe_base64)
    authentication_token
  end

  def empty_context
    empty_context_last_message.merge(empty_context_tapped_message)
  end

  def empty_context_last_message
    {
      'last_message' => {
        'result' => {
          'message_id' => nil
        }
      }
    }
  end

  def empty_context_tapped_message
    {
      'replace_last_message' => false,
      'tapped_message' => {
        'message_id' => nil
      }
    }
  end
end
