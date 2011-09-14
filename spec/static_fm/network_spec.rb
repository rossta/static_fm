require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "StaticFM integration" do

  def file_should_contain_desired_code(file_name, code)
    File.readlines(file_name).any? { |line| !!line.match(/#{Regexp.escape(code).downcase}/i) }
  end

  def file_should_contain_bytes(file_name)
    File.size(file_name).should > 128
  end

  describe "downloads" do
    it "should download assets in static.yml" do
      config = StaticFM::Asset.config
      assets = ENV['ASSET'].nil? ? config : {ENV['ASSET'] => config[ENV['ASSET']]}
      assets.each_pair do |asset_name, attributes|
        asset = StaticFM::Asset.find(asset_name)
        destination = "./spec/downloads/"
        installer = StaticFM::Installer.new(asset, destination)
        installer.download

        File.exist?(installer.file_name).should be_true
        file_should_contain_bytes(installer.file_name)
        file_should_contain_desired_code(installer.file_name, asset.name)
      end
    end
  end
end
