module Errational
  module Generators
    class InstallGenerator < Rails::Generators::NamedBase

      desc "This generator will create the necessary exception and error files in the lib/errational directory"

      source_root File.expand_path("../../templates", __FILE__)

      def print_message
        puts "Installing errational..."
      end

      def create_error_file
        @error_module_name = "#{class_name}Error"
        template("error_module.rb", "lib/errational/#{file_name}_error.rb")
      end

      def create_exception_file
        @exception_module_name = "#{class_name}Exception"
        template("exception_module.rb", "lib/errational/#{file_name}_exception.rb")
      end

      def create_configuration_file
        @namespace = class_name
        template("errational_configuration.rb", "config/initializers/errational_configuration.rb")
      end

      def create_partial_file
        template("_error_dialog.js.erb", "app/views/errational/_error_dialog.js.erb")
      end

    end
  end
end