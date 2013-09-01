class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, email: true
  validates_presence_of :password, on: :create

  before_save :ensure_auth_token_present

  private

  def ensure_auth_token_present
     self.auth_token ||= SecureRandom.uuid
  end
end
