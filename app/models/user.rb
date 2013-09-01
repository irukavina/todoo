class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, email: true
  validates_presence_of :password, on: :create
  validates :password, length: 8..20

  before_save :ensure_auth_token_present

  def auth_token_hash
    { auth_token: self.auth_token }
  end

  def reset_auth_token!
    update_attribute(:auth_token, generate_auth_token)
  end

  private

  def ensure_auth_token_present
     self.auth_token ||= generate_auth_token
  end

  def generate_auth_token
    "#{(self.id || 0).to_s(16)}-#{SecureRandom.uuid}"
  end
end
