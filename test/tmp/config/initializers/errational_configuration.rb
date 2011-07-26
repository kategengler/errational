#TODO is this the best place for this line?
ActiveSupport::Dependencies.autoload_paths << "#{Rails.root}/lib/errational"

Errational.setup do |config|
  # Namespace for name of exception and error modules, based on the name given at install time.
  # Note, if changing, change the module names in lib/namespace_error.rb and lib/namespace_exception.rb,
  # , as well as the filenames
  config.namespace = "RailsApp"

  # The response code given for exceptions that are handled.
  config.error_response_code = 203

  # The partial to be used for exceptions handled as the result of xhr actions
  config.error_partial = '/errational/error_dialog'

  # The logger to be used for NamespaceException::Loggable exceptions and unexpected exceptions
  config.logger = Rails.logger
end