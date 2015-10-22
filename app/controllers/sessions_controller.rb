class SessionsController < ApplicationController
  

  def new
    if logged_in?
      boot_to_profile
    else
      render :new
    end
  end
  def create
    if logged_in?
      boot_to_profile
    else
      @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
      if @user.nil?
        add_flash("Unknown user or password.", :message)
        redirect_to new_session_url
      else
        log_in!(@user)
        redirect_to user_url(@user)
      end
    end
  end
  def destroy
    log_out!(current_user)

  end


end
