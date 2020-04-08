class Merchant::DashboardController < ApplicationController
  before_action :require_merchant

  def index
  end

  private

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end
end