class Admin::MerchantsController < ApplicationController
  before_action :require_admin

  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:active?] == "toggle"
      merchant.toggle(:active?)
      merchant.toggle_all_items_status
      merchant.save
      flash[:success] = "The account for #{merchant.name} has been #{merchant.active? ? "enabled" : "disabled"}"
      redirect_to admin_merchants_path
    end
  end
end