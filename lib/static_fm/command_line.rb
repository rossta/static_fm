require 'static_fm'
require 'optparse'

module StaticFM

  class CommandLine

    def initialize(args)
      @args = args
    end

    def options
      @options ||= {}
    end

    def default_options
      {
        :compressed => false
      }
    end

    def method
      @args.any? && @args[0].to_sym
    end

    def execute
      case method
      when :install
        install @args[1], @args[2]
      when :list
        list
      else
        parser.help
      end
    end

    def install(asset_name, destination)
      Installer.download(asset_name, destination, default_options.merge(options))
    end

    def list
      Asset.recipe_names.join("\n")
    end

    def parser
      OptionParser.new do |opts|
        opts.banner = "Usage: static [options] COMMAND"

        opts.separator ""
        opts.separator "Options:"

        opts.on("-c", "--compressed", "Retrieve compressed version") do |host|
          options[:compressed] = true
        end
        #
        # opts.on("-N", "--namespace [NAMESPACE]", "Redis namespace") do |namespace|
        #   Resque.redis.namespace = namespace
        # end
        #
        # opts.on("-h", "--help", "Show this message") do
        #   puts opts
        #   exit
        # end

        opts.separator ""
        opts.separator "Commands:"
        opts.separator "  install ASSET DEST  Downloads asset to destination"
        opts.separator "  list                Lists available download recipes"
      end
    end
  end
end