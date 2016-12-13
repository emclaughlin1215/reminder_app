class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable
  has_many :tasks, dependent: :destroy

  before_save :ensure_authentication_token!

  def generate_secure_token_string
    SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
  end

  # Sarbanes-Oxley Compliance: http://en.wikipedia.org/wiki/Sarbanes%E2%80%93Oxley_Act
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W]).+/)
      errors.add :password, "must include at least one of each: lowercase letter, uppercase letter, numeric digit, special character."
    end
  end

  # Ensure the password is present.
  def password_presence
    password.present? && password_confirmation.present?
  end

  # Ensure the password and password confirmation match.
  def password_match
    password == password_confirmation
  end

  # Ensure an auth token is generated.
  def ensure_authentication_token!
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  # Generate the token using some magic? I think it's generating a token and
  # making sure that no user has that token already.
  def generate_authentication_token
    loop do
      token = generate_secure_token_string
      break token unless User.where(authentication_token: token).first
    end
  end

  # Create a new authentication token.
  def reset_authentication_token!
    self.authentication_token = generate_authentication_token
  end
end
