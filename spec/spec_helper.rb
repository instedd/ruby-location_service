$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'vcr'
require 'webmock'
require 'location_service'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :record => :none, :match_requests_on => [:path, :query] }
end

RSpec.configure do |config|
  config.after(:each) do
    LocationService.reload!
  end
end

