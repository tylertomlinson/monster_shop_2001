class Profile::OrdersController < ApplicationController
  before_action :require_current_user

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  private

  def require_current_user
    render file: "/public/404" unless current_user
  end
end