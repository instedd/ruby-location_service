require 'spec_helper'

describe LocationService::Fake::Client do

  let(:repository) { LocationService.repository }
  let(:client)     { LocationService.client }

  before(:each) do
    LocationService.fake!

    repository.make id: 'gadm:1',     name: "USA"
    repository.make id: 'gadm:1.1',   name: "California", parent_id: 'gadm:1'
    repository.make id: 'gadm:1.2',   name: "Texas"     , parent_id: 'gadm:1'
    repository.make id: 'gadm:1.1.1', name: "San Jose"  , parent_id: 'gadm:1.1'
  end

  it "should return details for several ids" do
    client.details(['gadm:1', 'gadm:1.1']).map(&:name).should eq(["USA", "California"])
  end

  it "should return children" do
    client.children('gadm:1').map(&:name).should =~ ["Texas", "California"]
  end

  it "should suggest based on name" do
    client.suggest('San').map(&:name).should =~ ["San Jose"]
  end

  it "should provide ancestors" do
    child = client.details(['gadm:1.1.1'], ancestors: true).first
    child.ancestor_ids.should eq(['gadm:1', 'gadm:1.1'])
    child.ancestors.map(&:name).should eq(['USA', "California"])
  end

  it "should provide empty ancestors collection" do
    child = client.details(['gadm:1'], ancestors: true).first
    child.ancestor_ids.should eq([])
    child.ancestors.should eq([])
  end

  it "should return shape if requested" do
    client.details(['gadm:1.1'], shapes: true).first.shape.should_not be_nil
  end

  it "should not return shape if not requested" do
    client.details(['gadm:1']).first.shape.should be_nil
  end
end
