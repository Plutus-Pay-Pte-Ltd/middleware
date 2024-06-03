# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    @current_user = authorize_request
    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = decode_token(header)
    User.find(decoded["user_id"]) if decoded
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    nil
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')[0]
  end
end
