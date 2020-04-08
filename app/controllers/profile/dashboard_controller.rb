class Profile::DashboardController < ApplicationController
  before_action :require_regular

  def index
    @user = current_user
  end

  private

  def require_regular
    render file: "/public/404" unless current_regular?
  end
end
