ENV["RAILS_ENV"] = "test"
$:.unshift File.dirname(__FILE__)
require "rails_app/config/environment"
require "rails/test_help"

# For generators
require "rails/generators/test_case"
require File.dirname(__FILE__) + '/../lib/errational'
require File.dirname(__FILE__) + '/../lib/generators/errational/install_generator'

