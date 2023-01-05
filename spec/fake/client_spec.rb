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
    expect(client.details(['gadm:1', 'gadm:1.1']).map(&:name)).to eq(["USA", "California"])
  end

  it "should return children" do
    expect(client.children('gadm:1').map(&:name)).to match(["California", "Texas"])
  end

  it "should suggest based on name" do
    expect(client.suggest('San').map(&:name)).to match(["San Jose"])
  end

  it "should provide ancestors" do
    child = client.details(['gadm:1.1.1'], ancestors: true).first
    expect(child.ancestor_ids).to eq(['gadm:1', 'gadm:1.1'])
    expect(child.ancestors.map(&:name)).to eq(['USA', "California"])
  end

  it "should provide empty ancestors collection" do
    child = client.details(['gadm:1'], ancestors: true).first
    expect(child.ancestor_ids).to eq([])
    expect(child.ancestors).to eq([])
  end

  it "should return shape if requested" do
    expect(client.details(['gadm:1.1'], shapes: true).first.shape).to_not be_nil
  end

  it "should not return shape if not requested" do
    expect(client.details(['gadm:1']).first.shape).to be_nil
  end
end
