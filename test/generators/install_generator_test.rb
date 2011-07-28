require 'test_helper'

class InstallGeneratorTest < Rails::Generators::TestCase
  tests Errational::Generators::InstallGenerator
  destination File.expand_path("../../tmp", __FILE__)

  def setup
    $stderr.stubs(:write)
    prepare_destination
  end

  def test_assert_all_files_are_properly_created
    run_generator ["RailsApp"]
    assert_file "config/initializers/errational_configuration.rb"
    assert_file "lib/errational/rails_app_error.rb"
    assert_file "lib/errational/rails_app_exception.rb"
    assert_file "app/views/errational/_error_dialog.js.erb"
  end
end
