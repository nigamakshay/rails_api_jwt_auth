class JsonWebToken
  class << self

    # Takes user_id, expiry time, and unique base key of Rails application.
    # Generates encoded token for the authorised user
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    # Takes token and uses the application's secret key to decode it.
    # Validates if token appended in the request is correct
    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end
  end
end