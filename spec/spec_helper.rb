$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'static_fm'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end

StaticFM::Logger.silence!

at_exit do
  # Run 'rake network' to test downloads
  # Run DOWNLOAD=preserve rake network to test downloads and keep directory for inspection
  if !!ENV['DOWNLOAD'] == "preserve" && File.directory?('./spec/downloads')
    system "rm ./spec/downloads/*"
  end
end