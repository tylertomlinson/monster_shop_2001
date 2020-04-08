class Profile::DashboardController < ApplicationController
  before_action :require_regular

  def index
  end

  private

  def require_regular
    render file: "/public/404" unless current_regular?
  end
end