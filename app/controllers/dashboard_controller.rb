class DashboardController < ApplicationController
  before_action :authenticate_user!

  def blank_dashboard
  end
end