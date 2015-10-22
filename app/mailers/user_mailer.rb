class UserMailer < ApplicationMailer
  default from: 'admin@labelinventory.com'

  def welcome_email(user)
    @user = user
    @url = activate_users_url(activation_token: @user.activation_token)
    mail(to: user.email, subject: "Welcome to Label Inventory")
  end
end
