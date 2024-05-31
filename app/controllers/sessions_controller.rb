class SessionsController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[destroy]
  def new
    # Render login form
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      if user.compliance_officer?
        session[:user_id] = user.id
        redirect_to companies_path
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
