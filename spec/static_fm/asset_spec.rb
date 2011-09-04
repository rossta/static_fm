require 'spec_helper'

describe StaticFM::Asset do

  before(:each) do
    @asset = StaticFM::Asset.new("backbone", {
      :url => "http://www.example.com/backbone.js",
      :version => "0.1"
    })
  end

  describe "initialize" do

    it "should initialize from config" do
      @asset.name.should == 'backbone'
      @asset.url.should == "http://www.example.com/backbone.js"
      @asset.version.should == "0.1"
    end

  end

  describe "host" do
    it "should return http://www.example.com" do
      @asset.host.should == "www.example.com"
    end
  end

  describe "path" do
    it "should return /backbone.js" do
      @asset.path.should == "/backbone.js"
    end

    it "should interpolate path version placeholder with given version" do
      asset = StaticFM::Asset.new("backbone", {
        :url => "http://www.example.com/backbone-{version}.js",
        :version => "0.1"
      })
      asset.path.should == "/backbone-0.1.js"
    end
  end

  describe "self.find" do
    before(:each) do
      StaticFM::Asset.add({
        "backbone" => {
        :url => "http://www.example.com/backbone.js",
        :version => "0.1"
      }})
    end

    it "should return asset from data in yml" do
      asset = StaticFM::Asset.find('backbone')
      asset.name.should == 'backbone'
      asset.url.should == "http://www.example.com/backbone.js"
      asset.version.should == "0.1"
    end

  end

end
