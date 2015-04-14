require 'logger'

module LocationService

  class Config
    attr_accessor :url
    attr_accessor :set
    attr_accessor :strict_params
    attr_accessor :logger

    def initialize
      self.logger = Logger.new(STDOUT)
    end

    def check_valid!
      raise "LocationService URL cannot be empty" if url.nil? || url.empty?
    end
  end

end
