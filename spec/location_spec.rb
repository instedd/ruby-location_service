require 'spec_helper'

describe Location do

  before(:all) do
    LocationService.setup do |config|
      config.url = 'http://localhost:8080' # Default port where location service runs in development
      config.set = 'gadm'
    end
  end

  around(:each) do |example|
    VCR.use_cassette('gadm-ne') do
      example.run
    end
  end

  it 'finds roots' do
    roots = Location.roots
    expect(roots).to have(2).items
    expect(roots.map(&:name)).to match ['Argentina', 'United States']
  end

  it 'finds multiple locations by ids' do
    locations = Location.details(["gadm:USA", "gadm:ARG"])
    expect(locations).to have(2).items
    expect(locations.map(&:name)).to match ['Argentina', 'United States']
  end

  it 'finds location by id' do
    location = Location.find("gadm:USA_5")
    expect(location).to_not be_nil

    expect(location.name).to eq("California")
    expect(location.type).to eq("State")
    expect(location.level).to eq(1)
    expect(location.ancestor_ids).to match ['gadm:USA']
    expect(location.shape).to be_nil
  end

  it 'returns nil location when not found' do
    expect(Location.find("gadm:USA_XX")).to be_nil
  end

  it 'suggests based on name' do
    locations = Location.suggest('Cali')
    expect(locations.map(&:name)).to match ['Calingasta', 'California']
  end

  it 'looks up based on lat lng' do
    locations = Location.lookup(-93.035854, 39.586283)
    expect(locations.map(&:name)).to match ['Chariton']
  end

  it 'looks up based on lat lng including ancestors' do
    location = Location.lookup(-93.035854, 39.586283, ancestors: true).first
    expect(location.ancestors.map(&:name)).to match ['United States', 'Missouri']
  end

  it 'returns children of a location' do
    expect(Location.find('gadm:ARG').children).to have(24).items
  end

  context 'options' do

    it 'includes locations shapes' do
      location = Location.find("gadm:USA_5", shapes: true)
      expect(location).to_not be_nil
      expect(location.shape).to_not be_nil
      expect(location.shape).to_not be_empty
    end

    it 'includes ancestors' do
      location = Location.find("gadm:USA_5", ancestors: true)
      expect(location).to_not be_nil
      expect(location.ancestors).to have(1).item
      expect(location.ancestors.map(&:name)).to match ['United States']
    end

    it 'limits results' do
      ids = 30.times.map{|i| "gadm:USA_#{i}"}
      locations = Location.details(ids, limit: 10)
      expect(locations).to have(10).items
    end

    it 'offsets results' do
      ids = 30.times.map{|i| "gadm:USA_#{i}"}
      locations = Location.details(ids, limit: 10, offset: 24)
      expect(locations).to have(5).items
    end

    it 'scopes results' do
      locations = Location.details(['gadm:ARG_1', 'gadm:ARG_2', 'gadm:USA_1', 'gadm:USA_2'], scope: 'gadm:ARG')
      expect(locations).to have(2).items
    end

  end

  context 'sets' do

    it 'does not retrieve location from a different set' do
      expect(Location.find("ne:ARG")).to be_nil
    end

    it 'can override default set' do
      location = Location.find("ne:ARG", set: 'ne')
      expect(location).to_not be_nil
      expect(location.name).to eq('Argentina')
    end

  end


end
