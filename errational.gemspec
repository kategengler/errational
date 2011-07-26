# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "errational/version"

Gem::Specification.new do |s|
  s.name        = "errational"
  s.version     = Errational::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kate Gengler", "Brian Olore"]
  s.email       = ["errational@surrationale.net"]
  s.homepage    = ""
  s.summary     = %q{A gem for nice exception handling.}
  s.description = %q{Nice error handling}

  s.rubyforge_project = "errational"

  s.files         = Dir.glob("**/*")
  s.require_paths = ["lib"]

end
