class Location < Struct.new("Location", :id, :name, :type, :ancestor_ids, :level, :shape, :ancestors)

  def self.roots(opts={})
    as_locations client.children(nil, opts)
  end

  def self.find(id, opts={})
    as_location client.details([id], opts).first
  end

  def self.details(id_or_ids, opts={})
    as_locations client.details(Array(id_or_ids), opts)
  end

  def self.suggest(name, opts={})
    as_locations client.suggest(name, opts)
  end

  def self.lookup(x, y, opts={})
    as_locations client.lookup(x, y, opts)
  end

  def self.children(parent_id, opts={})
    as_locations client.children(parent_id, opts)
  end


  def children(opts={})
    self.class.children(self.id, opts)
  end

  def ancestor_ids
    super || []
  end


  def self.as_location(args)
    return nil if args.nil?

    location = new *(%W(id name type ancestorsIds level shape).map{|key| args[key]})
    location.ancestors = as_locations(args['ancestors']) if args['ancestors']
    return location
  end

  def self.as_locations(args_array)
    args_array.map{|args| self.as_location(args)}
  end

  def self.client
    @client ||= LocationService.client
  end

end
