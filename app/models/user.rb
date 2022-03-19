class User < ApplicationRecord
  belongs_to :accounts
  validates :email, uniqueness: true
  validates_format_of :email, with: /@/, :message => "has incorrect format"

  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  validates :password_digest, presence: true, format: { with: PASSWORD_FORMAT }

  has_secure_password

  def is_admin?
    is_root?
  end

end
