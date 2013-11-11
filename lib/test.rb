#!/bin/env ruby
$: << '.'

require 'flume-logger'

#ng_logger = FlumeLogger.new('localhost', 9090, :ng)
#ng_logger.progname = 'test-ng'
#ng_logger.info "Hello INFO from ruby"
#ng_logger.warn "Hello WARN from ruby"
#ng_logger.error "Hello ERROR from ruby"

og_logger = FlumeLogger.new('localhost', 9090, :og)
og_logger.progname = 'test-og'
og_logger.info "Hello from ruby"
