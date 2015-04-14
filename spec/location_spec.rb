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
    roots.should have(2).items
    roots.map(&:name).should =~ ['Argentina', 'United States']
  end

  it 'finds multiple locations by ids' do
    locations = Location.details(["gadm:USA", "gadm:ARG"])
    locations.should have(2).items
    locations.map(&:name).should =~ ['Argentina', 'United States']
  end

  it 'finds location by id' do
    location = Location.find("gadm:USA_5")
    location.should_not be_nil

    location.name.should eq("California")
    location.type.should eq("State")
    location.level.should eq(1)
    location.ancestor_ids.should =~ ['gadm:USA']
    location.shape.should be_nil
  end

  it 'returns nil location when not found' do
    Location.find("gadm:USA_XX").should be_nil
  end

  it 'suggests based on name' do
    locations = Location.suggest('Cali')
    locations.map(&:name).should =~ ['Calingasta', 'California']
  end

  it 'looks up based on lat lng' do
    locations = Location.lookup(-93.035854, 39.586283)
    locations.map(&:name).should =~ ['Chariton']
  end

  it 'looks up based on lat lng including ancestors' do
    location = Location.lookup(-93.035854, 39.586283, ancestors: true).first
    location.ancestors.map(&:name).should =~ ['Missouri', 'United States']
  end

  it 'returns children of a location' do
    Location.find('gadm:ARG').children.should have(24).items
  end

  context 'options' do

    it 'includes locations shapes' do
      location = Location.find("gadm:USA_5", shapes: true)
      location.should_not be_nil
      location.shape.should_not be_nil
      location.shape.should_not be_empty
    end

    it 'includes ancestors' do
      location = Location.find("gadm:USA_5", ancestors: true)
      location.should_not be_nil
      location.ancestors.should have(1).item
      location.ancestors.map(&:name).should =~ ['United States']
    end

    it 'limits results' do
      ids = 30.times.map{|i| "gadm:USA_#{i}"}
      locations = Location.details(ids, limit: 10)
      locations.should have(10).items
    end

    it 'offsets results' do
      ids = 30.times.map{|i| "gadm:USA_#{i}"}
      locations = Location.details(ids, limit: 10, offset: 24)
      locations.should have(5).items
    end

    it 'scopes results' do
      locations = Location.details(['gadm:ARG_1', 'gadm:ARG_2', 'gadm:USA_1', 'gadm:USA_2'], scope: 'gadm:ARG')
      locations.should have(2).items
    end

  end

  context 'sets' do

    it 'does not retrieve location from a different set' do
      Location.find("ne:ARG").should be_nil
    end

    it 'can override default set' do
      location = Location.find("ne:ARG", set: 'ne')
      location.should_not be_nil
      location.name.should eq('Argentina')
    end

  end


end
