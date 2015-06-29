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
        parent = args[:parent] || find(args[:parent_id])

        location.id = args[:id] || fake_id(parent)
        location.name = args[:name] || "Location #{location.id}"
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

      def fake_id(parent)
        parent_id = parent ? parent.id : nil
        count = @locations.select{|l| l.ancestor_ids.last == parent_id}.size
        parent ? "#{parent.id}_#{count}" : "fake_#{count}"
      end

      def fake_shape
        nw, se = 2.times.map { [(rand(180)-90), (rand(360)-180)] }
        ne = [nw[0], se[1]]
        sw = [nw[1], se[0]]
        [ nw, ne, se, sw ]
      end

    end
  end
end
