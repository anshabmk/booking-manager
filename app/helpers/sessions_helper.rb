# frozen_string_literal: true

# Helper methods for session
module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    user_type = user.class.name == 'User' ? 'admin' : 'player'

    session[:user] = { type: user_type, id: user.id }
  end

  # Returns the current logged-in user (if any).
  def current_user
    return @current_user if @current_user

    session_user = session[:user]

    return unless session_user

    const_name = session_user['type'] == 'admin' ? 'User' : 'Player'
    @current_user = Object.const_get(const_name).find_by(id: session_user['id'])

    @current_user
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Logs out the current user.
  def log_out
    session.delete(:user)
    @current_user = nil
  end

  # Returns nil if user is not authenticated
  def authenticate_session(session_params)
    admin_login = session_params[:admin_login].to_i == 1
    email = session_params[:email].downcase
    user = admin_login ? User.find_by(email: email) : Player.find_by(email_id: email)

    user&.authenticate(session_params[:password])
  end

  # Returns the path upon successfull login
  def successful_login_path
    return bills_path if session['user']['type'] == 'admin'

    bill_amounts_path
  end

  # Returns true if the user type is admin
  def admin?
    current_user.class.name == 'User'
  end
end
