module SessionsHelper
  
  # Returns true if a user is logged in.
  def logged_in?
    true if session[:user_id]
  end
  
  # Logs a user out.
  def log_out
    session.delete(:user_id)
    session.delete(:name)
    redirect_to root_url
  end
end
