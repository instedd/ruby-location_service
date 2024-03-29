# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'location_service/version'

Gem::Specification.new do |spec|
  spec.name          = "location_service"
  spec.version       = LocationService::VERSION
  spec.authors       = ["Santiago Palladino"]
  spec.email         = ["spalladino@manas.com.ar"]

  spec.summary       = %q{Ruby client for InSTEDD location service}
  spec.homepage      = "https://github.com/instedd/ruby-location_service"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|fixtures)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rest-client', "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.5"
  spec.add_development_dependency "rspec", "= 3.9.0"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 2.3.1"

  spec.required_ruby_version = '>= 2.4.0'
end
