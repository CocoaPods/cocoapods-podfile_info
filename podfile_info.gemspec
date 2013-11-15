# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_pod_bay/version'

Gem::Specification.new do |spec|
  spec.name          = "cocoapods-open"
  spec.version       = OpenPodBay::VERSION
  spec.authors       = ["TODO"]
  spec.email         = ["TODO"]
  spec.description   = %q{CocoaPods plugin to show information on installed pods in the current project}
  spec.summary       = %q{Show a info on installed pods}
  spec.homepage      = "TODO"
  spec.license       = "TODO"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end