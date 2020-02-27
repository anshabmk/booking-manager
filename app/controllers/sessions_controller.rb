# frozen_string_literal: true

# Sessions controller
class SessionsController < ApplicationController
  skip_before_action :require_admin_login

  def new
    redirect_to(successful_login_path) if logged_in?
  end

  def create
    authenticated_user = authenticate_session(params[:session])

    if authenticated_user
      if authenticated_user.class.name == 'Player' && !authenticated_user.activated
        flash.now[:danger] = 'Your account is not activated. Please contact administrator for activation.'

        render 'new'
      else
        log_in(authenticated_user)
        redirect_to(successful_login_path)
      end
    else
      flash[:danger] = "E-mail/Password combination doesn't match"

      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to(login_path)
  end
end
