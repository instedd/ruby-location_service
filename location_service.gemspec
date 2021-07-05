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

  spec.add_dependency 'rest-client', "~> 2.1"

  spec.add_development_dependency "bundler", "~> 2.2.21"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "= 2.14"
  spec.add_development_dependency "vcr", "~> 5.1.0"
  spec.add_development_dependency "webmock", "~> 3.13.0"

end
