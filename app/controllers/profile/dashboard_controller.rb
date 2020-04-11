class Profile::DashboardController < ApplicationController
  before_action :require_current_user

  def index
    @user = current_user
  end

  def orders
    @user = current_user
  end

  private

  def require_current_user
    render file: "/public/404" unless current_user
  end
end
