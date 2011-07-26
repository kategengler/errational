module Errationalify

  class Parent < RuntimeError;
  end

  class Loggable < Parent
    def initialize(message = "")
      super(message)
    end
  end

  def self.included(module_that_has_included_this_module)
    create_classes_from_constants_in_modules_within_error_module
  end


  def self.error_class(message = "", parent = Parent, &block)
    block ||= Proc.new do
      define_method(:initialize) { super(message) }
    end
    Class.new(parent, &block)
  end

  def self.intermediate_class
    lambda {
      error_class do
        def initialize(message = "")
          super(message)
        end
      end
    }
  end

  def self.create_classes_from_constants_in_modules_within_error_module
    sub_modules = modules_in(Errational.error_base)
    sub_modules.each do |module_name|
      current_module = Errational.error_base.const_get(module_name)
      create_classes_from_constants_in(current_module)
    end
  end

  def self.create_classes_from_constants_in(current_module)
    current_module.constants.each do |constant_name|
      error_constant = current_module.const_get(constant_name)
      error_class_name = classify_name(constant_name)
      parent_class = parent_class_for(current_module)
      create_error_class_with(error_class_name, error_constant, parent_class)
    end
  end

  def self.parent_class_for(current_module)
    parent_class_name = name_of(current_module)

    if already_a_class_on_the_class_that_has_included_this_module?(parent_class_name)
      parent_class = Errational.exception_base.const_get(parent_class_name)
    else
      parent_class = Errational.exception_base.const_set(parent_class_name, intermediate_class.call)
    end
    parent_class
  end

  def self.already_a_class_on_the_class_that_has_included_this_module?(module_name)
    included_in_constants?(Errational.exception_base, module_name) && defined?(Errational.exception_base.const_get(module_name)) && Errational.exception_base.const_get(module_name).is_a?(Class)
  end

  def self.name_of(current_module)
    current_module.name.split("::").second
  end

  def self.create_error_class_with(class_name, constant, parent)
    Errational.exception_base.const_set(class_name, error_class(constant, parent))
  end

  def self.classify_name(constant_name)
    constant_name.to_s.downcase.camelize
  end

  def self.included_in_constants?(mod, constant_name)
    mod.constants.include? constant_name
  end

  def self.modules_in(mod)
    mod.constants.select { |name| mod.const_get(name).is_a? Module }
  end

end