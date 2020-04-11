class Profile::OrdersController < ApplicationController
  before_action :require_current_user

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end
end