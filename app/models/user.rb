class User < ActiveRecord::Base

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

end
