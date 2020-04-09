class SessionsController < ApplicationController 

    def new
        if !current_user.nil?
            if current_admin?
                redirect_to admin_path
            elsif current_merchant?
                redirect_to merchant_path
            else current_regular?
                redirect_to profile_path
            end
        flash[:notice] = "You are already logged in!"
        end
    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:success] = "Welcome #{user.name}, you have successfully logged in!"
            redirect_to admin_path if current_admin?
            redirect_to merchant_path if current_merchant?
            redirect_to profile_path if current_regular?
        else
            flash[:error] = "Please enter valid email and/or password to login"
            render :new
        end
    end

    def destroy
        session.delete(:cart)
        session.delete(:user_id)
        flash[:notice] = "You have successfully logged out!"
        redirect_to "/"
    end 
end

   