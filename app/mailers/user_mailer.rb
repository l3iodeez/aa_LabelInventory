class UserMailer < ApplicationMailer
  default from: 'admin@labelinventory.com'

  def welcome_email(user)
    @user = user
    @url = "http://www.labelinventory.com"
    mail(to: user.email, subject: "Welcome to Label Inventory")
  end
end
