# frozen_string_literal: true

module Services
  class Base
    include Helpers::Common
    include Helpers::Menus::Actions
    include Helpers::Talker::Actions

    attr_reader :bot, :chat_id, :user

    def initialize(bot:, user:)
      @bot = bot
      @chat_id = user.id
      @user = user
      yield if block_given?
    end
  end
end
