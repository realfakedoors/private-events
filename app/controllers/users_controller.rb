class UsersController < ApplicationController
  
  before_action only: [:destroy] do
    correct_user?(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    User.find(params[:id]).destroy
  end
  
  def dashboard
    if logged_in?
      @user = current_user
    else
      redirect_to login_url
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name)
    end
    
end