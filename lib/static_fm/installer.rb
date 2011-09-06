require 'typhoeus'
require 'uri'

module StaticFM

  class Installer

    def self.download(asset_name, destination, opts = {})
      Installer.new(Asset.find(asset_name), destination, opts).download
    end

    attr_accessor :compressed

    def initialize(asset, destination, opts = {})
      @asset = asset
      @destination  = destination
      @compressed   = opts[:compressed]
    end

    def download
      Logger.info "download\t#{@asset.display_name}"
      request = Typhoeus::Request.new(url, :max_redirects => 1, :follow_location => true)
      request.on_complete do |resp|
        File.open(@destination, "w+") { |file|
          file.write(resp.body)
          Logger.info "complete\t#{@asset.display_name} #{@destination}"
         }
      end

      hydra = Typhoeus::Hydra.new
      hydra.queue request
      hydra.run
    end

    def url
      compressed? ? @asset.compressed_url : @asset.url
    end

    def compressed?
      !!@compressed
    end

    def file_name

    end

  end
end