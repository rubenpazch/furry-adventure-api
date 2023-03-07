# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded_token = JWT.decode(token.split(' ').last, SECRET_KEY)
    decoded = decoded_token.first if decoded_token
    HashWithIndifferentAccess.new decoded
  end
end
