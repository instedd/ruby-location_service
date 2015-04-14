module LocationService

  class Config
    attr_accessor :url
    attr_accessor :set
    attr_accessor :strict_params

    def check_valid!
      raise "LocationService URL cannot be empty" if url.nil? || url.empty?
    end
  end

end
