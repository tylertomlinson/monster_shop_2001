class Merchant::OrdersController < ApplicationController
    before_action :require_merchant

    def show
        @order = Order.find(params[:id])
    end
    

end