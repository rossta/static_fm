require 'spec_helper'
require 'static_fm/command_line'

describe StaticFM::CommandLine do

  before(:each) do
    StaticFM::Installer.stub!(:download)
  end

  describe "execute" do
    describe "install" do
      it "should initiate default install" do
        StaticFM::Installer.should_receive(:download).with("backbone", "/path/to/backbone.js", { :compressed => false })
        StaticFM::CommandLine.new(["install", "backbone", "/path/to/backbone.js"]).execute
      end

      it "should initiate an install with compressed option set" do
        StaticFM::Installer.should_receive(:download).with("backbone", "/path/to/backbone.js", { :compressed => true })
        StaticFM::CommandLine.new(["--compressed", "install", "backbone", "/path/to/backbone.js"]).execute
      end
    end
  end
end
