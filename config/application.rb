require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'dotenv' ; Dotenv.load '.env.local', ".env.#{Rails.env}"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Users
  class Application < Rails::Application
    config.encoding = 'utf-8'

    # Found in: http://stackoverflow.com/questions/9073446/where-do-you-store-your-rails-applications-version-number
    #Let your own development environment update it for you from your latest Git tag! (which you should also be doing;)
    if Rails.env.development?
      # Update version file from latest git tag
      File.open('config/version', 'w') do |file|
        file.write `git describe --tags --always` # or equivalent
      end
    end

    config.version = File.read('config/version')

    config.generators do |g|
      g.test_framework  :rspec
    end

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
