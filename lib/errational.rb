require 'rails'
require 'rails/generators'
require 'active_support/dependencies'
require 'errational/errationality'
require 'errational/errationalify'
require 'generators/errational/install_generator'

module Errational

  def self.setup
    yield self
  end

  mattr_accessor :namespace
  mattr_accessor :error_response_code
  mattr_accessor :error_partial
  mattr_accessor :logger

  def self.error_base_name
    "#{Errational.namespace}Error"
  end

  def self.exception_base_name
    "#{Errational.namespace}Exception"
  end

  def self.error_base
    Kernel.const_get(Errational.error_base_name)
  end

  def self.exception_base
    Kernel.const_get(Errational.exception_base_name)
  end
end