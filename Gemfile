source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '4.2.3'

gem 'rails-api'

gem 'spring', :group => :development


gem 'sqlite3'



# To use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'puma', '2.11.3'
gem 'oj'
gem 'rabl-rails'
gem 'responders', '~> 2.0'
gem 'airbrake'
group :development, :test do
  gem 'rspec-rails', '3.3.2'
  gem 'timecop', '0.7.4'
  gem 'brakeman', require: false
  gem 'simplecov', require: false
  gem 'guard-rspec', '4.6.0', require: false
  gem 'rubocop'
  gem 'json_spec'
  gem 'factory_girl', '4.5.0'
  gem 'pact'
  gem 'dotenv-rails'
end

group :test do
  gem 'faker'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

gem 'pact_broker-client', group: [:development, :test]
gem 'pg', ' >= 0.18.2'