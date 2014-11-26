# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oklink/version'

Gem::Specification.new do |spec|
  spec.name          = "oklink"
  spec.version       = Oklink::VERSION
  spec.authors       = ["liu tao"]
  spec.email         = ["support@oklink.com"]
  spec.summary       = %q{oklink api sdk}
  spec.description   = %q{wrap api}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = Dir['README.md', 'lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "httparty", "~> 0.13"
  spec.add_development_dependency "hashie", "~> 3.3"
end
