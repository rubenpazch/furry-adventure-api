class RoleSerializer
  include JSONAPI::Serializer
  set_type :role
  attributes :id, :name, :profile_id, :is_root, :parent_id, :account_id
  has_many :user, class_name: "User", foreign_key: "user_id"
end
