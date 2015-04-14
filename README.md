# LocationService

[![Build Status](https://travis-ci.org/instedd/ruby-location_service.svg?branch=master)](https://travis-ci.org/instedd/ruby-location_service)

Ruby client for [InSTEDD location service](github.com/instedd/location_service).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'location_service', git: 'https://github.com/instedd/ruby-location_service.git'
```

And then execute:

    $ bundle

## Usage

Setup the service with the URL to the location service server, and optionally specify a set to be used in all requests:

```ruby
LocationService.setup do |config|
  config.url = 'http://location-service.instedd.org'
  config.set = 'gadm'
  config.logger = Logger.new(STDOUT)
end
```

Use the client class to execute any requests:

```ruby
client = LocationService.client
client.lookup 20, 10
client.details 'gadm:ARG'
client.children 'gadm:ARG'
client.suggest 'argen'
```

Or use the `Location` struct with the equivalent methods, that return the response already wrapped in a `Location` object.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Tests

Run tests using:

```bash
$ bundle exec rspec spec/
```

Integration tests use VCR, recorded against a location service instance, populated with the sources specified in `fixtures/scripts/sources.sh`.

To add new tests, set up a new location service instance, load the data, temporarily set VCR's `default_cassette_options` in `spec_helper` to `:all`, and run the tests. This will create or update the cassettes, for running the tests independently of a running locations server.

## Contributing

1. Fork it ( https://github.com/instedd/location_service/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
