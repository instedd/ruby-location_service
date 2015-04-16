module LocationService
  module Fake
    class Client

      def initialize(repository, config)
        @repository = repository
        @config = config
      end

      def lookup(x, y, opts={})
        filter_locations(opts) do |location|
          location.shape.size == 4 &&
            location.shape[0][0] <= x && x <= location.shape[2][0] &&
            location.shape[0][1] <= y && y <= location.shape[2][1]
        end
      end

      def details(ids, opts={})
        ids = Array(ids)
        filter_locations(opts) do |location|
          ids.include?(location.id)
        end
      end

      def children(id, opts={})
        filter_locations(opts) do |location|
          location.ancestor_ids.last == id
        end
      end

      def suggest(name, opts={})
        filter_locations(opts) do |location|
          location.name.start_with?(name)
        end
      end

      private

      def filter_locations(opts, &block)
        set = opts[:set] || @config.set
        locations = @repository.locations.select{|l| set.nil? || l.set == set}.select(&block)
        apply_opts(locations, opts)
      end

      def apply_opts(locations, opts)
        locations.map do |orig|
          location = orig.clone
          location.shape = nil if !opts[:shapes]
          location.ancestors = location.ancestor_ids.map{|aid| @repository.find(aid)} if opts[:ancestors]
          location
        end
      end

    end
  end
end
