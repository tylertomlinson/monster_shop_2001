class Merchant::ItemsController < ApplicationController
  before_action :require_merchant
  
  def index
  end

  def update
    item = Item.find(params[:id])
    merchant = item.merchant
    item.toggle!(:active?)
    redirect_to "/merchants/#{merchant.id}/items"
    if item.active?
      flash[:success] = "#{item.name} is now available for sale."
    else
      flash[:success] = "#{item.name} is no longer for sale."
    end
  end

end
