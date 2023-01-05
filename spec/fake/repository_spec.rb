require 'spec_helper'

describe LocationService::Fake::Repository do

  let(:repository) { LocationService::Fake::Repository.new }

  it "should make a new location without args" do
    location = repository.make
    expect(location).to be_a(Location)
    expect(location.id).to_not be_nil
    expect(location.name).to_not be_nil
    expect(location.level).to_not be_nil
    expect(location.type).to_not be_nil
    expect(location.shape).to_not be_nil
    expect(location.lat).to_not be_nil
    expect(location.lng).to_not be_nil
    expect(repository.locations.count).to eq(1)
  end

  it "should make a new location from args" do
    location = repository.make(name: 'USA', id: 'gadm:1', level: 1)
    expect(location.name).to eq('USA')
    expect(location.id).to eq('gadm:1')
    expect(location.level).to eq(1)
    expect(repository.locations.count).to eq(1)
  end

  it "should make a new location with parent" do
    parent = repository.make
    child = repository.make(parent_id: parent.id)
    expect(child.ancestor_ids).to eq([parent.id])
  end

  it "should make a new location with ancestors" do
    root = repository.make
    parent = repository.make(parent_id: root.id)
    child = repository.make(parent_id: parent.id)
    expect(child.ancestor_ids).to eq([root.id, parent.id])
    expect(repository.locations.count).to eq(3)
  end

end
