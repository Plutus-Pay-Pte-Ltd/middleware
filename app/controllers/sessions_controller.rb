class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  def new
    # Render login form
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user
      if user.password_digest.nil?
        session[:user_id] = user.id
        redirect_to new_user_password_path(user)
      elsif user.authenticate(params[:password])
        session[:user_id] = user.id
        if user.compliance_officer?
          redirect_to companies_path
        else
          redirect_to blank_dashboard_path
        end
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
