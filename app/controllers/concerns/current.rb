module Current
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  def set_current_user
    if request.headers['Authorization'].present?
      token = request.headers['Authorization'].split(' ').last
      decoded_token = decode_token(token)
      @current_user = User.find_by(id: decoded_token['user_id']) if decoded_token
    end
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secret_key_base)[0] rescue nil
  end
end
