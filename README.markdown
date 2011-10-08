# static_fm

A static file manager: install and upgrade vendor assets like javascript libraries and css frameworks.

## Usage

Install the gem.

  gem install static_fm

  # or with Bundler
  gem 'static_fm', :group => :development


Download your favorite library to your app.

  $ static install jquery public/javascripts/

## Why?

StaticFM aims to be a useful tool for quickly adding common asset libraries and frameworks to your app without having to google for the right version or the URLs.

## About

This project is still under heavy development

## Development

    rake                            # Runs non-network specs
    rake network                    # Runs all specs, will hit network to test all downloads
    ASSET=backbone rake network     # Runs all non-network specs + network check for backbone asset

## Contributing to static_fm

To add a new library to static_fm, fork the project, add an entry to static.yml on a feature branch and submit a pull request.

## Best practices

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright (c) 2011 Ross Kaffenberger. See LICENSE.txt for
further details.

