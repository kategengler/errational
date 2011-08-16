# This module is where you can override the default behavior of exception classes or add other exception classes.
# The default behavior of the exception classes is to create an exception with the message of the constant.
# Exception classes that override generated exception classes must be defined as children of their parent module's generated class.
# Example:
# module ApplicationException
#   include Errationalify
#
#   class ServiceFault < Loggable
#     def initialize(service_name)
#       message = sprintf(ApplicationError::SERVICE_FAULT, service_name)
#     end
#   end
# end
# module ApplicationError
#   module General
#     UNEXPECTED = "An error has occurred in the application. Please try again."
#   end
#   module Loggable
#     SERVICE_FAULT = "The response from %s cannot be processed. Please try again"
#   end
# end

module RailsAppException
  include Errationalify
end