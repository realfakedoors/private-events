class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(name: params[:name])
    if user
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:warning] = "Invalid user name!"
      redirect_to login_path
    end
  end
  
  def destroy
    log_out if logged_in?
  end
end