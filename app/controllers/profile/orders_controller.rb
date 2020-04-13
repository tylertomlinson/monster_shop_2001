class Profile::OrdersController < ApplicationController
  before_action :require_current_user

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    order = Order.find(params[:id])
    order.cancel
    flash[:success] = "Order ##{order.id} has been cancelled"
    redirect_to profile_path
  end
end
