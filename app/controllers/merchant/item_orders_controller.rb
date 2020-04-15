class Merchant::ItemOrdersController < ApplicationController
    before_action :require_merchant

    def update
        @item_order = ItemOrder.find(params[:id])
        @item_order.fulfill_item_order
        @item_order.order.package if @item_order.order.item_orders.pluck(:status).all?("fulfilled")
        redirect_to merchant_order_path(@item_order.order_id)
    end
    
end