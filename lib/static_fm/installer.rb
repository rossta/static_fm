require 'net/http'
require 'uri'

module StaticFM

  class Installer

    def self.download(asset_name, destination)
      Installer.new(Asset.find(asset_name), destination).download
    end

    def initialize(asset, destination)
      @asset = asset
      @destination = destination
    end

    def download
      Net::HTTP.start(@asset.host) { |http|
        resp = http.get(@asset.path)
        File.open(@destination, "w+") { |file|
          file.write(resp.body)
         }
      }
    end

  end
end