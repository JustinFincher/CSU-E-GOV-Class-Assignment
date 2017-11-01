class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to user
    else
      # Create an error message.
      flash.now[:red] = '验证失败，请检查登陆用户名/密码'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url_path
  end
end
