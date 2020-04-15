class Merchant::ItemsController < ApplicationController
  before_action :require_merchant
  
  def index
    @merchant = current_user.merchant
    @items = current_user.merchant.items
  end

  def new
    @merchant = current_user.merchant
  end

  def create
    @merchant = current_user.merchant
    @item = @merchant.items.new(item_params)
    if @item.save
      flash[:success] = "#{@item.name} has been created."
      redirect_to "/merchant/items"
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    merchant = @item.merchant
    if params[:status_update]
      toggle_status
    elsif @item.update(item_params)
      redirect_to "/merchants/#{merchant.id}/items"
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:success] = "#{item.name} Successfully Deleted."
    redirect_to "/merchants/#{item.merchant.id}/items"
  end

  private

  def toggle_status
    @item.update_status
    if @item.active?
      flash[:success] = "#{@item.name} is now available for sale."
    else
      flash[:success] = "#{@item.name} is no longer for sale."
    end
    redirect_to "/merchants/#{@item.merchant_id}/items"
  end

  def item_params
    params.permit(:name, :description, :item, :price, :inventory)
  end

end
