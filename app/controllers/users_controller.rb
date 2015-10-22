class UsersController < ApplicationController
  before_action :verify_logged_in, except: [:new, :create, :index]
  before_action :verify_rights, except: [:new, :create, :index]

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
    if @user.save
      log_in!(@user)
      redirect_to user_url(@user)
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
    @user.update(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end



end
