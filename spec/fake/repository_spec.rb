require 'spec_helper'

describe LocationService::Fake::Repository do

  let(:repository) { LocationService::Fake::Repository.new }

  it "should make a new location without args" do
    location = repository.make
    location.should be_a(Location)
    location.id.should_not be_nil
    location.name.should_not be_nil
    location.level.should_not be_nil
    location.type.should_not be_nil
    location.shape.should_not be_nil
    location.lat.should_not be_nil
    location.lng.should_not be_nil
    repository.locations.count.should eq(1)
  end

  it "should make a new location from args" do
    location = repository.make(name: 'USA', id: 'gadm:1', level: 1)
    location.name.should eq('USA')
    location.id.should eq('gadm:1')
    location.level.should eq(1)
    repository.locations.count.should eq(1)
  end

  it "should make a new location with parent" do
    parent = repository.make
    child = repository.make(parent_id: parent.id)
    child.ancestor_ids.should eq([parent.id])
  end

  it "should make a new location with ancestors" do
    root = repository.make
    parent = repository.make(parent_id: root.id)
    child = repository.make(parent_id: parent.id)
    child.ancestor_ids.should eq([root.id, parent.id])
    repository.locations.count.should eq(3)
  end

end
