class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  private

  def current_user
    return nil if session[:session_token].nil?

    current_user ||=
      User.find_by(session_token: session[:session_token])
  end

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def require_account!
    notice = ["You need to be logged in to access this page"]
    redirect_to new_session_url, notice: notice unless logged_in?
  end

  def require_no_account!
    notice = ["You're already logged in"]
    redirect_to root_url, notice: notice if logged_in?
  end
end
