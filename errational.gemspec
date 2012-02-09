# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "errational/version"

Gem::Specification.new do |s|
  s.name        = "errational"
  s.version     = Errational::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kate Gengler", "Brian Olore"]
  s.email       = ["errational@surrationale.net"]
  s.summary     = %q{A gem for nice exception handling.}
  s.description = %q{Nice error handling}
  s.homepage    = "https://github.com/kategengler/errational"

  s.rubyforge_project = "errational"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency('rails', '>=3.0.0')
  s.add_development_dependency('bundler', '~> 1.0')
  s.add_development_dependency('mocha')
  s.add_development_dependency('appraisal', '>= 0.4.0')

end
