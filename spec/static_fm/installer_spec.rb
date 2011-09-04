require 'spec_helper'

describe StaticFM::Installer do

  before(:each) do
    @asset = StaticFM::Asset.new("backbone", { :url => "http://www.example.com/backbone-src.js" })
  end

  describe "download" do

    before(:each) do
      @installer = StaticFM::Installer.new(@asset, "./spec/backbone.js")
      @http = mock(Net::HTTP, :get => mock("Response", :body => "source code"))
      @file = mock(File, :write => nil)
      Net::HTTP.stub!(:start).and_yield(@http)
      File.stub!(:open).and_yield(@file)
    end

    it "should install given asset to given destination" do
      Net::HTTP.should_receive(:start)
        .with("www.example.com")
        .and_yield(@http)
      @http.should_receive(:get).with('/backbone-src.js')
      @installer.download
    end

    it "should write response body to file destination" do
      File.should_receive(:open)
        .with('./spec/backbone.js', 'w+')
        .and_yield(@file)

      @file.should_receive(:write).with("source code")
      @installer.download
    end

  end
end


# require 'net/http'
#
# Net::HTTP.start("static.flickr.com") { |http|
#   resp = http.get("/92/218926700_ecedc5fef7_o.jpg")
#   open("fun.jpg", "wb") { |file|
#     file.write(resp.body)
#    }
# }