class ApplicationController < ActionController::Base
  before_action :require_login

  include SessionsHelper

  private

  def require_login
    return if logged_in?

    flash[:danger] = 'You must be logged in to view the contents of this page'

    redirect_to(login_url)
  end
end
