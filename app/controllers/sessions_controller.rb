class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the bill's index page.
      log_in(user)
      redirect_to(bills_path)
    else
      # Create an error message.
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to(login_path)
  end
end
