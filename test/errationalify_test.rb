require 'test_helper'

class ErrationalTest < ActiveSupport::TestCase

  def test_exception_base_includes_errationalify
    assert(Errational.exception_base.include? Errationalify)
  end

  def test_exception_base_has_classes_with_ancestry_based_on_structure_of_error_modules
    assert(Errational.exception_base::Unexpected.ancestors.include? Errational.exception_base::General)
    assert(Errational.exception_base::LogThis.ancestors.include? Errational.exception_base::Loggable)
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