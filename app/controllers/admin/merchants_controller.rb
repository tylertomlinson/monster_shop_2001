class Admin::MerchantsController < ApplicationController
  before_action :require_admin

  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.toggle(:active?) if params[:active?] == "toggle"
    if merchant.save
      flash[:success] = "The account for #{merchant.name} has been #{merchant.active? ? "enabled" : "disabled"}"
      redirect_to admin_merchants_path
    else
      flash[:error] = merchant.errors.full_messages.to_sentence
    end
  end
end