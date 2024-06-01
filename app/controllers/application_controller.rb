class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_user, :user_signed_in?

  private

  def authenticate_user!
    redirect_to login_path, alert: 'You need to sign in to access this page.' unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize_compliance_officer
    redirect_to root_path, alert: 'Not authorized' unless current_user&.compliance_officer?
  end
end
