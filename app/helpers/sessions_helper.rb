module SessionsHelper
  
  # Returns the current user, if any.
  def current_user
    User.find_by(id: session[:user_id])
  end
  
  # Returns true if a user is logged in.
  def logged_in?
    true if current_user
  end
  
  # Logs a user out.
  def log_out
    session.delete(:user_id)
    session.delete(:name)
    redirect_to root_url
  end
end
