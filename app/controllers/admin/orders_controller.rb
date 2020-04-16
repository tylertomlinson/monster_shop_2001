class Admin::OrdersController < OrdersController
  before_action :require_admin
    def update
      @order = Order.find(params[:id])
      @order.ship
      redirect_to admin_path
    end
end
