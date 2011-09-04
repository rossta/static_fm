module StaticFM
  class Updater

    def self.update!
      installer = new
      yield installer
      installer.update!
    end

    attr_accessor :url, :dir, :files

    def files
      @files ||= []
    end

    def update!
      @files.each do |file|
        system `wget #{File.join(@url, file)} -O#{File.join(@dir, file)}`
      end
    end
  end
end