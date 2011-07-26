Errational.setup do |config|
  config.namespace = "RailsApp"
  config.error_response_code = 203
  config.error_partial = '/error_dialog'
  config.logger = Rails.logger
end