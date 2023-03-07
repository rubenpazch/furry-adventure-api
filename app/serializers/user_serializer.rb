# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  set_type :user
  attributes :id,
             :name,
             :first_name,
             :last_name,
             :avatar,
             :email,
             :role,
             :role_id,
             :last_login,
             :created_at,
             :isSuperAdmin
  :account_id
  # belongs_to :account
  # has_one :profile
  belongs_to :role, class_name: 'Role', foreign_key: 'role_id', serializer: RoleSerializer
end
