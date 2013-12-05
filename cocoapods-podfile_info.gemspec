# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-podfile_info.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-podfile_info'
  spec.version       = PodfileInfo::VERSION
  spec.authors       = ['Taras Kalapun', 'Joshua Kalpin']
  spec.description   = %q{CocoaPods plugin to show information on installed pods in the current project}
  spec.summary       = %q{Show a info on installed pods}
  spec.homepage      = 'https://github.com/cocoapods/cocoapods-podfile_info'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end