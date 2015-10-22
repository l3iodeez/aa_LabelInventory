class UsersController < ApplicationController
  before_action :verify_logged_in, except: [:new, :create, :index, :activate]
  before_action :verify_rights, except: [:new, :create, :index, :activate]

  def index
    if logged_in?
      boot_to_profile
    else
      redirect_to new_session_url
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    if logged_in?
      boot_to_profile
    else
      @user = User.new
      render :new
    end
  end

  def create
    @user = User.new(user_params)
    @user.activation_token = SecureRandom.urlsafe_base64
    if @user.save
      email = UserMailer.welcome_email(@user)
      email.deliver
      add_flash("Check your email for activation link", :message)
      redirect_to root_url
    else
      @user.errors.full_messages.each do |msg|
        add_flash_now(msg, :message)
      end
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def activate
     @user = User.find_by_activation_token(params[:activation_token])
     @user.activate
     log_in!(@user)
     redirect_to user_url(@user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end



end
