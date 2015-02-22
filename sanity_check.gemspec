# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sanity_check/version'

Gem::Specification.new do |spec|
  spec.name          = "sanity_check"
  spec.version       = SanityCheck::VERSION
  spec.authors       = ["Thomas Cioppettini"]
  spec.email         = ["thomas.cioppettini@gmail.com"]
  spec.summary       = %q{Rake Tasks that review your code before deploy.}
  spec.description   = %q{Run tests, check best practices, and run security checks before.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "brakeman", ">= 3.0.0"
  spec.add_dependency "rails_best_practices", ">= 1.15.6"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
