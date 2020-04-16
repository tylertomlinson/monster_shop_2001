class Merchant::ItemOrdersController < ApplicationController
  before_action :require_merchant_employee

  def update
      @item_order = ItemOrder.find(params[:id])
      if @item_order.quantity <= @item_order.item.inventory
        @item_order.fulfill_item_order
        flash[:success] = "You have fulfilled an order for #{pluralize(@item_order.quantity, @item_order.item.name)}"
      end
      @item_order.order.package if @item_order.order.item_orders.pluck(:status).all?("fulfilled")
      redirect_to merchant_order_path(@item_order.order_id)
  end
end