class Profile::DashboardController < ApplicationController
  before_action :require_current_user

  def index
    @user = current_user
  end
end
