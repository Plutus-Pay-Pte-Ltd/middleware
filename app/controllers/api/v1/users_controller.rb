# app/controllers/api/v1/users_controller.rb
module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_request, only: [:new, :create]
      before_action :authorize_compliance_officer, only: [:index, :destroy]

      def index
        @users = User.all
        render json: @users
      end

      def destroy
        @user = User.find(params[:id])
        @user.destroy
        render json: { notice: 'User was successfully deleted.' }
      end

      def update_password
        @user = @current_user
        if @user.update(user_params)
          render json: { notice: "Password updated successfully." }
        else
          render json: { error: "Failed to update password." }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role)
      end

      def authorize_compliance_officer
        render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user.compliance_officer?
      end
    end
  end
end
