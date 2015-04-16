module LocationService
  module Fake
    class Repository

      def initialize
        @locations = []
      end

      def locations
        @locations
      end

      def add(location)
        @locations << location
      end

      def find(id)
        @locations.find{|l| l.id == id}
      end

      def make(args={})
        location = Location.new
        location.id = args[:id] || "fake:#{@locations.size}"
        location.name = args[:name] || "Location#{@locations.size}"

        parent = find(args[:parent_id])
        location.ancestor_ids = args[:ancestor_ids] || (parent ? (parent.ancestor_ids + [parent.id]) : [])
        location.level = args[:level] || (parent ? parent.level + 1 : 0)
        location.type = args[:type] || "Type #{location.level}"
        location.shape = args[:shape] || fake_shape
        location.lat = args[:lat] || (rand(180)-90)
        location.lng = args[:lng] || (rand(360)-180)

        locations << location
        location
      end

      private

      def fake_shape
        nw, se = 2.times.map { [(rand(180)-90), (rand(360)-180)] }
        ne = [nw[0], se[1]]
        sw = [nw[1], se[0]]
        [ nw, ne, se, sw ]
      end

    end
  end
end
