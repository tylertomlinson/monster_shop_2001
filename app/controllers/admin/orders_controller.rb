class Admin::OrdersController < ApplicationController

    def update
        @order = Order.find(params[:id])
        @order.ship
        redirect_to admin_path
    end
    

end