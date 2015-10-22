class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    if session[:session_token]
      User.find_by_session_token(session[:session_token])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    add_flash("You have been logged in.", :message)
  end

  def log_out!(user)
    user.reset_session_token!
    add_flash("You have been logged out.", :message)
    redirect_to new_session_url
  end

  def boot_to_profile
    redirect_to user_url(current_user)
  end

  def verify_rights
    if current_user != User.find(params[:id])
      add_flash("You do not have the right to view/edit this object", :message)
      redirect_to user_url(current_user)
    end
  end

  def verify_logged_in
    unless logged_in?
      add_flash("You must log in before performing this action", :message)
      redirect_to new_session_url
    end
  end

  def add_flash(text, type)
    flash[type] ||= []
    flash[type] << text
  end

  def add_flash_now(text, type)
    flash.now[type] ||= []
    flash.now[type] << text
  end

  def flash_errors_now(object)
    object.errors.full_messages.each do |msg|
      add_flash_now(msg, :message)
    end
  end

  def flash_errors(object)
    object.errors.full_messages.each do |msg|
      add_flash_now(msg, :message)
    end
  end




end
