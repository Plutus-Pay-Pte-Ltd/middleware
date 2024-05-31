class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  before_action :authorize_compliance_officer, only: [:index, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted.'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def authorize_compliance_officer
    redirect_to(root_path, alert: 'Not authorized') unless current_user.compliance_officer?
  end
end
