class ApplicationController < ActionController::Base
  include ActionView::Helpers::TextHelper
  protect_from_forgery with: :exception

  helper_method :cart, :current_user, :current_merchant?, :current_admin?,
    :require_current_user

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_regular?
    current_user && current_user.regular?
  end

  def current_merchant?
    current_user && current_user.merchant?
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def require_current_user
    render file: "/public/404" unless current_user
  end

  def require_admin
    render file: "/public/404" unless current_admin?
  end

  def require_merchant
    render file: "/public/404" unless current_merchant?
  end
end
