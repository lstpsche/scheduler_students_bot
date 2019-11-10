# frozen_string_literal: true

module Actions
  module Features
    class Base < Actions::Base
      # 'Common' module is in base
      # 'Talker::Actions' module is in base
      # 'Menus::Actions' module is in base

      # attrs from base -- :bot, :chat_id, :user, :params

      # 'initialize' is in base
      # 'show' is in base
      # 'back' mock is in base

      # 'create_button' is in base
      # 'create_buttons' is in base
      # 'create_markup' is in base
      # 'create_button_for_kb' is in base
      # 'button_args' is in base

      # 'before_show' mock is in base
      # 'after_show' mock is in base
      # 'callback' mock is in base
    end
  end
end
