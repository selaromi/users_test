class UserResource < BaseResource
  attributes :username, :email, :password
  has_many :user_settings, :user_roles
  has_one :profile, class: 'Profile', foreign_key_on: :related
end