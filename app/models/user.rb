require_relative '../../app/errors/custom_errors'

class User < ActiveRecord::Base
  include GenerateRelatedResources

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true
  has_many :roles, through: :user_roles
  has_many :user_roles, dependent: :destroy
  has_many :user_settings, dependent: :destroy
  has_many :devices, dependent: :destroy
  has_one :profile, dependent: :destroy

  after_save :initialize_settings

  CREATE_BEFORE_SAVE = []
  CREATE_AFTER_SAVE = [
    :profile,
    :roles
  ]

  def initialize_settings
    Setting.all.each do |setting|
      user_settings << UserSetting.create(setting_id: setting.id, value: setting.default_value)
    end
  end

end
