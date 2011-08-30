require 'errational'
require 'rails'

module Errational
	class Railtie < ::Rails::Railtie
		initializer 'errational.on_load' do
			# Note:
			# When using rescue_from, assert_raises no longer works
			# Test for the results of the exception handling or expect exception handlers to be called
			ActiveSupport.on_load(:action_controller) do
				include Errationality

				rescue_from Exception, :with => :handle_unexpected_exception
				rescue_from Errational.exception_base::Parent, :with => :handle_exception if defined?(Errational.exception_base::Parent)
			end
		end
	end
end
