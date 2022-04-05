class User < ApplicationRecord
  belongs_to :account
  has_one :profile
  belongs_to :role, class_name: "Profiles::Role", foreign_key: "role_id"
  #belongs_to :person, class_name: "person", foreign_key: "person_id"
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

  scope :users_by_account, ->(account_id) { where('account_id = ?', account_id) }

  def is_super_admin?
    isSuperAdmin?
  end

end
