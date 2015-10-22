class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  before_validation :ensure_session_token

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end
