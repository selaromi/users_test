class UserSetting < ActiveRecord::Base
  belongs_to :user
  belongs_to :setting
end
