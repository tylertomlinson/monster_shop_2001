class SessionsController < ApplicationController

  def new
    unless current_user.nil?
      login_redirect
      flash[:error] = "You are already logged in!"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}, you have successfully logged in!"
      login_redirect
    else
      flash[:error] = "Please enter valid email and/or password to login"
      render :new
    end
  end

  def destroy
    session.delete(:cart)
    session.delete(:user_id)
    flash[:success] = "You have successfully logged out!"
    redirect_to "/"
  end

  private

  def login_redirect
    redirect_to "/admin" if current_admin?
    redirect_to "/merchant" if current_merchant?
    redirect_to "/profile" if current_regular?
  end
end