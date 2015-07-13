Airbrake.configure do |config|
  config.api_key = ENV['ERRBIT_API_KEY']
  config.host    = ENV['ERRBIT_HOST']
  config.port    = ENV['ERRBIT_PORT']
  config.secure  = config.port == 443
  config.ignore_only = []
  config.development_environments = []
end
