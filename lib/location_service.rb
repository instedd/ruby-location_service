require "location_service/version"
require "location_service/client"
require "location_service/config"

module LocationService

  def self.client
    LocationService::Client.new(self.config)
  end

  def self.setup
    yield self.config
  end

  def self.config
    @config ||= LocationService::Config.new
  end

end
