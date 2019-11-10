# frozen_string_literal: true

module Helpers
  module Menus
    module Registration
      private

      def launch_registration
        ::Actions::Users::Registration.new(bot: bot, tg_user: user).launch
      end
    end
  end
end
