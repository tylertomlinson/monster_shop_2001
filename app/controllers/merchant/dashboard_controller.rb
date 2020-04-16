class Merchant::DashboardController < ApplicationController
  before_action :require_merchant_employee

  def index
    @merchant = Merchant.find(current_user.merchant_id)
  end
end
