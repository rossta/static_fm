require "static_fm/installer"
require "static_fm/updater"
require "static_fm/asset"

require 'logger'

module StaticFM

  class Logger

    class << self

      def info(*args)
        return nil if silent?
        logger.info *args
      end

      def logger
        @logger ||= ::Logger.new $stdout, 'w+'
      end

      def silence!
        @silent = true
      end

      def silent?
        !!@silent
      end
    end
  end

  Logger.logger.datetime_format = "%Y-%m-%d %H:%M:%S"

end