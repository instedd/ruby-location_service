require 'rest_client'

module LocationService
  class Client

    attr_reader :config

    def initialize(config)
      config.check_valid!
      @config = config
    end

    def lookup(x, y, opts={})
      get '/lookup', opts.merge(x: x, y: y)
    end

    def details(ids, opts={})
      get '/details', opts.merge(id: ids.join(","))
    end

    def children(id, opts={})
      get '/children', opts.merge(id: id)
    end

    def suggest(name, opts={})
      get '/suggest', opts.merge(name: name)
    end

    private

    def get path, opts
      check_opts!(opts) if config.strict_params
      opts.merge!(set: config.set) if config.set && !opts[:set]
      uri = URI.join(@config.url, path).to_s

      config.logger.debug "Requesting #{uri} with #{opts}"
      JSON.parse RestClient.get(uri, params: opts)
    end

    def check_opts!(opts)
      opts.keys.each do |key|
        raise "#{key} is not allowed" if not %W(x y id name ancestors shapes limit offset scope set).include?(key.to_s)
      end
    end

  end
end
