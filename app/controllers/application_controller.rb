class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :signed_in?
  
  def current_user
  	return @current_user if @current_user
  	if session[:user_id]
  		@current_user = User.find(session[:user_id])
  	end
  end

  def signed_in?
  	if session[:user_id]
  		return true
  	else
  		return false
  	end
  end

  def require_login
  	unless signed_in?
  		flash[:errors] = "you must log in to access this section"
  		redirect_to new_session_path
  	end
  end
end
