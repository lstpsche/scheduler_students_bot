# frozen_string_literal: true

module Services
  class PasswordCreatorService < Base
    # attrs from base -- :bot, :chat_id, :user
    attr_reader :password, :validity_token, :http, :request

    # 'initialize' is in base

    def launch
      @password = generate_password
      @secure_token = generate_secure_token
      add_validity_token_to_user
      set_user_password
      send_password_to_user
    end

    private

    def generate_password
      SecureRandom.hex(3)
    end

    def generate_secure_token
      SecureRandom.base64(100)
    end

    def auth_token
      user.auth_token
    end

    def add_validity_token_to_user
      # make request to generate_bot_secure_token
      # validity_token = user.bot_secure_token
      user.update(bot_secure_token: secure_token)
    end

    def set_user_password
      prepare_request
      send_request
      # TODO: handle unprocessable entity from response here
    end

    # TODO: move to a separate service
    # Services::RequestSender
    def prepare_request
      uri = URI.parse('http://localhost:3000/users/password')
      header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Validity-Token': secure_token
      }
      body = {
        user: {
          id: user.id,
          password: password
        }
      }

      @http = Net::HTTP.new(uri.host, uri.port)
      @request = Net::HTTP::Post.new(uri.request_uri, header)
      @request.body = body.to_json
    end

    def send_request
      @response = http.request(request)
    end

    def send_password_to_user
      send_message(text: 'Your *one-time* password is:')
      send_message(text: password)
    end
  end
end
