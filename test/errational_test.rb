require 'test_helper'

class ErrationalTest < ActiveSupport::TestCase

  def test_setup_block_yields_self
    Errational.setup do |config|
      assert_equal Errational, config
    end
  end

  def test_lib_errational_in_load_path

  end

  def test_error_base_name
    assert_equal "RailsAppError", Errational.error_base_name
  end

  def test_exception_base_name
    assert_equal "RailsAppException", Errational.exception_base_name
  end

  def test_error_base
    assert Errational.error_base.is_a? Module
    assert_equal Errational.error_base.name, Errational.error_base_name
  end

  def test_exception_base
    assert Errational.exception_base.is_a? Module
    assert_equal Errational.exception_base.name, Errational.exception_base_name
  end

  def test_exception_base_includes_errationalify
    assert(Errational.exception_base.include? Errationalify)
  end

  def test_exception_base_has_classes_with_ancestry_based_on_structure_of_error_modules
    assert(Errational.exception_base::Unexpected.ancestors.include? Errational.exception_base::General)
    #assert(DisplayDocException::SocketServiceError.ancestors.include? DisplayDocException::Loggable)
  end

  def test_every_constant_not_a_module_in_error_module_is_class_within_exception_module
    Errational.error_base.constants.each do |c|
      if Errational.error_base.const_get(c).is_a? String
        assert(Errational.exception_base.const_get(c.to_s.downcase.camelize).is_a? Class)
        assert(Errational.exception_base.const_get(c.to_s.downcase.camelize).ancestors.include? Errationalify::Parent)
      end
    end
  end

end
