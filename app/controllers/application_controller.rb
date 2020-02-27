class ApplicationController < ActionController::Base
  before_action :require_admin_login

  include SessionsHelper

  private

  def require_login
    return if logged_in?

    flash.now[:danger] = 'You must be logged in to view the contents of this page.'

    redirect_to(login_url)
  end

  def require_admin_login
    return if logged_in? && current_user.class.name == 'User'

    flash.now[:danger] = 'You must be logged in as admin to view the contents of this page.'

    redirect_to(login_url)
  end

  def require_player_login
    return if logged_in? && current_user.class.name == 'Player'

    flash.now[:danger] = 'You must be logged in as a player to view the contents of this page.'

    redirect_to(login_url)
  end
end
