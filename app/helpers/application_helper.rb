module ApplicationHelper
  
  def login_required
    return true if logged_in?
    session[:return_to] = request.request_uri
    redirect_to new_session_path and return false
  end
  
  
  def logged_in?
    session[:user_id] != nil
  end
  
end
