class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(name: params[:session][:name])
    if !user.nil? then session[:user_id] = user.id
  end
end