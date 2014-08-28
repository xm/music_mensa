class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:token])
  end

  def logged_in?
    !!current_user
  end

  def login_user!(user)
    user.reset_session_token!
    session[:token] = user.session_token
  end

  def logout_user!(user)
    user.reset_session_token!
    session[:token].clear
  end

  def require_login
    redirect_to login_url unless logged_in?
  end
end
