# frozen_string_literal: true

module Handlers
  module TextCommands
    class StartHandler < Base
      # attrs from base -- :bot, :chat_id, :user

      # 'initialize' is in base

      def handle
        launch_registration unless student_registered?(id: chat_id)
      end
    end
  end
end
