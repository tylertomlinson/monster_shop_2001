class Merchant::DashboardController < ApplicationController
  before_action :require_merchant

  def index
    if current_user.merchant_id != nil
      @merchant = Merchant.find(current_user.merchant_id)
    end
  end

  private

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end
end
