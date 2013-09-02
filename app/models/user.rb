class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, email: true, uniqueness: true
  validates :password, length: 8..20

  before_save :ensure_auth_token_present

  has_many :tasks

  def authentication_data_hash
    { email: self.email,
      auth_token: self.auth_token }
  end

  def archive_completed_tasks!
    tasks.where(completed: true).update_all(archived: true)
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
