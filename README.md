# FlumeLogger

This gem implements a subclass of Ruby's Logger class that logs directly to flume. It writes to a flume agent using thrift RPC, support both FlumeNG (default) or FlumeOG (ThriftLegacy).

## Installation

Add this line to your application's Gemfile:

    gem 'flume-logger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flume-logger

## Usage

    require 'flume-logger'
    
    logger = FlumeLogger.new('localhost', 9090)
    logger.progname = 'test-flume-ng'
    logger.info "Hello INFO from ruby"
    logger.warn "Hello WARN from ruby"
    logger.error "Hello ERROR from ruby"
    
    og_logger = FlumeLogger.new('localhost', 9090, :og)
    og_logger.progname = 'test-flume-og'
    og_logger.info "Hello from ruby"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
