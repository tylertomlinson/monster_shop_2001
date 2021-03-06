class UsersController < ApplicationController

  def new; end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name}! You are now registered and logged in!"
      redirect_to profile_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to "/profile"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def update_password
    user = current_user
    user.update(user_params)
    if user.save
      flash[:success] = "Your password has been updated."
      redirect_to profile_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      render :edit_password
    end
  end

  def edit_password
  end

  private

  def user_params
    params.permit(:name,
      :address,
      :city,
      :state,
      :zip,
      :email,
      :password,
      :password_confirmation)
  end
end
