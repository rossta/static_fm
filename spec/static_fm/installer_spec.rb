require 'spec_helper'

describe StaticFM::Installer do

  before(:each) do
    @asset = StaticFM::Asset.new("backbone", { :url => "http://www.example.com/backbone-src.js" })
    @installer = StaticFM::Installer.new(@asset, "./spec/backbone-src.js")
  end

  describe "download" do

    before(:each) do
      @response = mock('Response', :body => "source code")
      @request = mock(Typhoeus::Request, :on_complete => nil)
      @hydra = mock(Typhoeus::Hydra, :queue => nil, :run => nil)
      @file = mock(File, :write => nil)
      Typhoeus::Request.stub!(:new).and_return(@request)
      Typhoeus::Hydra.stub!(:new).and_return(@hydra)
      @request.stub!(:on_complete).and_yield(@response)
      File.stub!(:open).and_yield(@file)
    end

    it "should install given asset to given destination" do
      Typhoeus::Request.should_receive(:new)
        .with("http://www.example.com/backbone-src.js", { :follow_location => true, :max_redirects => 1 })
        .and_return(@request)
      @installer.download
    end

    it "should write response body to file destination" do
      File.should_receive(:open)
        .with('./spec/backbone-src.js', 'w+')
        .and_yield(@file)

      @file.should_receive(:write).with("source code")
      @installer.download
    end

    it "should use compressed url if option present" do
      @asset.compressed = 'backbone-min.js'
      @installer.compressed = true
      Typhoeus::Request.should_receive(:new)
        .with("http://www.example.com/backbone-min.js", { :follow_location => true, :max_redirects => 1 })
      @installer.download
    end

    it "should default to current directory if no destination specified" do
      installer = StaticFM::Installer.new(@asset, nil)

      File.should_receive(:open)
        .with('./backbone-src.js', 'w+')
        .and_yield(@file)

      @file.should_receive(:write).with("source code")
      installer.download
    end

  end

  describe "url" do
    it "should use asset url by default" do
      @installer.url.should == "http://www.example.com/backbone-src.js"
    end

    it "should use compressed url if option and compressed filename present" do
      @asset.compressed = "backbone-min.js"
      @installer.compressed = true
      @installer.url.should == "http://www.example.com/backbone-min.js"
    end
  end

  describe "file_name" do
    before(:each) do
      File.stub!(:directory?).and_return(false)
    end
    it "should return directory + asset filename if destination is directory" do
      File.stub!(:directory?).and_return(true)
      @installer.destination = "./spec/vendor/"
      @installer.file_name.should == "./spec/vendor/backbone-src.js"
    end

    it "should return destination otherwise" do
      @installer.file_name.should == "./spec/backbone-src.js"
    end
  end
end
