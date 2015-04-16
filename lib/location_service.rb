require "location_service/version"
require "location_service/client"
require "location_service/config"
require "location_service/location"

require "location_service/fake/client"
require "location_service/fake/repository"

module LocationService

  def self.setup
    yield self.config
  end

  def self.client
    if @repository
      LocationService::Fake::Client.new(@repository, self.config)
    else
      LocationService::Client.new(self.config)
    end
  end

  def self.config
    @config ||= LocationService::Config.new
  end

  def self.repository
    @repository
  end

  def self.repository=(value)
    @repository = value
  end

end
