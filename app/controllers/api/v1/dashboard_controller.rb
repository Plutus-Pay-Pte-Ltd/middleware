module Api
  module V1
    class DashboardController < ApplicationController
      before_action :authenticate_user!

      def blank_dashboard
      end
    end
  end
end