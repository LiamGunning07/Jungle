class User < ApplicationRecord
  has_secure_password

  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
 


  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
  
end
