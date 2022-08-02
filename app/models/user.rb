class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }
  validates :password_digest, presence: true

  def self.authenticate_with_credentials(email_address, password)
    @user = User.find_by_email(email_address.strip.downcase)

    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

end
