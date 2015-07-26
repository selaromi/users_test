Airbrake.configure do |config|
  config.api_key = ENV['ERRBIT_API_KEY']
  config.host    = ENV['ERRBIT_HOST']
  config.port    = ENV['ERRBIT_PORT']
  config.secure  = config.port == ENV['ERRBIT_SECURE_PORT']
  config.ignore_only = []
  config.development_environments = []
end
