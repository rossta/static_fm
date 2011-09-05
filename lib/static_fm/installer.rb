require 'typhoeus'
require 'uri'

module StaticFM

  class Installer

    def self.download(asset_name, destination, opts = {})
      Installer.new(Asset.find(asset_name), destination, opts).download
    end

    def initialize(asset, destination, opts = {})
      @asset = asset
      @destination = destination
      @opts = opts
    end

    def download
      request = Typhoeus::Request.new(@asset.url, :max_redirects => 1, :follow_location => true)
      request.on_complete do |resp|
        File.open(@destination, "w+") { |file|
          file.write(resp.body)
         }
      end

      hydra = Typhoeus::Hydra.new
      hydra.queue request
      hydra.run
    end

  end
end