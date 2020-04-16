class Admin::OrdersController < ApplicationController
  before_action :require_admin

  def update
    @order = Order.find(params[:id])
    @order.ship
    redirect_to admin_path
  end

  def index
    @user = User.find(params[:user_id])
  end

  def show
    @order = Order.find(params[:id])
  end
end
