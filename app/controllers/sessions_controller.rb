class SessionsController < ApplicationController
  def new
  end

  def create
  	if @user = User.find_by(email: params[:email])
  		if @user.authenticate(params[:password])
  			session[:user_id] = @user.id
  			redirect_to show_path, flash: {success: "Welcome back"}
  		else
  			redirect_to new_session_path, notice: "password is wrong"
  		end
  	else
  		redirect_to new_session_path, notice: "Email not found"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path, notice: "Logged out"
  end
end
