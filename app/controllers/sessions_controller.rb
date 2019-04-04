class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(name: params[:session][:name])
    if user
      log_in_as(user)
      redirect_to dashboard_path
    else
      flash.now[:warning] = "Invalid user name!"
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
  end
end