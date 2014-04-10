# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'salesforce/chatter/version'

Gem::Specification.new do |spec|
  spec.name          = "salesforce-chatter"
  spec.version       = Salesforce::Chatter::VERSION
  spec.authors       = ["Dylan Vaughn", "Dan Wanek"]
  spec.email         = ["dylan.vaughn@stlondemand.com","dan@crisply.com"]
  spec.summary       = %q{A library for the Salesforce Chatter API}
  spec.description   = %q{A library for the Salesforce Chatter API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "yajl-ruby"
  spec.add_dependency "faraday"
  spec.add_dependency "oauth2"
  spec.add_dependency "hashie"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
