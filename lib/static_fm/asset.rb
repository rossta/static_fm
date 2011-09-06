require 'yaml'
require 'uri'

module StaticFM

  class Asset

    class << self

      def find(name)
        new(name, config[name])
      end

      def dir
        @dir ||= File.join(File.dirname(File.expand_path(__FILE__)), "..", "..")
      end

      def add(attributes)
        config.merge!(attributes)
      end

      def config
        @config ||= default_config
      end

      def reset
        @config = default_config
      end

      def config=(attributes)
        @config = attributes
      end

      def default_config
        @default_config ||= YAML::load_file(File.join(dir, "config", "static.yml"))
      end

      def recipe_names
        config.keys
      end

    end


    attr_accessor :name, :url, :version, :compressed, :description, :tags

    def initialize(name, attributes = {})
      @name = name
      attributes.each_pair do |attribute, value|
        self.send("#{attribute}=", value)
      end

      update_url_with_version!
    end

    def host
      parsed_uri.host
    end

    def path
      parsed_uri.path
    end

    def basename
      File.basename(@url)
    end

    def compressed_path
      @compressed && path.gsub(basename, @compressed)
    end

    def compressed_url
      @compressed && @url.gsub(basename, @compressed)
    end

    def display_name
      [name, version].compact.join(':')
    end

    protected

    def parsed_uri
      @parsed_uri ||= URI.parse(@url)
    end

    def update_url_with_version!
      @url.gsub!(/\{version\}/, @version) unless @version.nil?
    end
  end

end