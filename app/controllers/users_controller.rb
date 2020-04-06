class UsersController < ApplicationController

    def new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id    
            flash[:notice] = "Welcome #{@user.name}! You are now registered and logged in!"
            redirect_to "/profile"
        else
            flash[:notice] = "The email and/or password were incorrect, please try again." 
            redirect_to "/register"
        end
    end

    def show
        @user = current_user
    end 


    private

    def user_params
        params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
    end

    
end 