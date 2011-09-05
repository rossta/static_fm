require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "StaticFM integration" do

  describe "downloads" do
    it "should download assets in static.yml" do
      pending
      StaticFM::Asset.config.each_pair do |asset_name, attributes|
        asset = StaticFM::Asset.find(asset_name)
        destination = "./spec/downloads/#{asset.basename}"
        StaticFM::Installer.new(asset, destination).download
        File.exist?(destination).should be_true
        File.size(destination).should > 128
        File.readlines(destination).should include(/backbone/i)
      end
    end
  end
end
