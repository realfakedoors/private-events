class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
    # Confirms the correct user is logged in.
    def correct_user?(id)
      @user = User.find_by(id: id)
      redirect_to(root_url) unless current_user == @user
    end
    
end
