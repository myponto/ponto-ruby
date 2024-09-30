# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ponto/version'

Gem::Specification.new do |spec|
  spec.name          = "ponto"
  spec.version       = Ponto::VERSION
  spec.authors       = ["Ponto"]
  spec.email         = ["info@ibanity.com"]
  spec.summary       = "Ponto Ruby Client"
  spec.description   = "A Ruby wrapper for the Ponto API."
  spec.homepage      = "https://documentation.myponto.com/api/ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", ">= 1.8.0"
  spec.add_development_dependency "rspec", "3.9.0"
  spec.add_development_dependency "webmock", "1.24.2"
  spec.add_development_dependency "byebug"
end
