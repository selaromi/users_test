# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
TEST_SETTINGS = [
  %w(KEY_1 KEY_1_DESCRIPTION 10),
  %w(KEY_2 KEY_2_DESCRIPTION 20),
  %w(KEY_3 KEY_3_DESCRIPTION 30),
  %w(KEY_4 KEY_4_DESCRIPTION 40)
]

TEST_SETTINGS.each do |setting|
  Setting.create(setting_key:setting[0],setting_description:setting[1],default_value:setting[2])
end
