# LocationService

Ruby client for [InSTEDD location service](github.com/instedd/location_service).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'location_service'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install location_service

## Usage

Setup the service with the URL to the location service server, and optionally specify a set to be used in all requests:

```ruby
LocationService.setup do |config|
  config.url = 'http://location-service.instedd.org'
  config.set = 'gadm'
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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/instedd/location_service/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
