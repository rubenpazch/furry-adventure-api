class UserSerializer
  include JSONAPI::Serializer
  set_type :user
  attributes :email, :first_name, :last_name, :name, :avatar, :last_login
  #belongs_to :account
  #has_one :profile
  #belongs_to :role, class_name: "Profiles::Role", foreign_key: "role_id"
end
