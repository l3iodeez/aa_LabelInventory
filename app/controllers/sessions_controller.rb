class SessionsController < ApplicationController
  before_action :verify_activated, only: :create
  before_action :boot_if_logged, only: [:new, :create]

  def new

      render :new

  end

  def create

    if @user.nil?
      add_flash("Unknown user or password.", :message)
      redirect_to new_session_url
    else
      log_in!(@user)
      redirect_to user_url(@user)
    end

  end

  def destroy
    log_out!(current_user)
  end

  def verify_activated
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    unless @user && @user.activated
      add_flash("You must activate your account before logging in. Check your email for the activation message.", :message)
      redirect_to root_url
    end
  end

  def boot_if_logged
    if logged_in?
      boot_to_profile
    end
  end

end
