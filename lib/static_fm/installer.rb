require 'typhoeus'
require 'uri'

module StaticFM

  class Installer

    def self.download(asset_name, destination, opts = {})
      Installer.new(Asset.find(asset_name), destination, opts).download
    end

    attr_accessor :compressed, :destination

    def initialize(asset, destination, opts = {})
      @asset = asset
      @destination  = destination
      @compressed   = opts[:compressed]
    end

    def download
      Logger.info "download\t#{@asset.display_name}"
      request = Typhoeus::Request.new(url, :max_redirects => 1, :follow_location => true)
      request.on_complete do |resp|
        File.open(file_name, "w+") { |file|
          file.write(resp.body)
          Logger.info "complete\t#{@asset.display_name} #{file_name}"
         }
      end

      hydra = Typhoeus::Hydra.new
      hydra.queue request
      hydra.run
    end

    def url
      # @asset.url_with_options(options)
      @asset.url_with_options({ :compress => compressed? })
    end

    def compressed?
      !!@compressed
    end

    def file_name
      if File.directory?(@destination)
        File.join(@destination, @asset.file_name)
      else
        @destination
      end
    end

  end
end