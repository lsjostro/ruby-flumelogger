class FlumeLogger < ::Logger
  
  attr_reader :client
  
  HOST = ::Socket.gethostname
  PRIORITY = {
    "FATAL"    => 0,
    "ERROR"    => 1,
    "WARN"     => 2,
    "INFO"     => 3,
    "DEBUG"    => 4,
    "TRACE"    => 5 
  }
  
  def initialize(host, port, flume_type=:ng, headers={})
    super(::FlumeLogger::Eventserver.new(host, port, flume_type))
    @type = flume_type
    @headers = headers
  end
  
  def add(severity, message = nil, progname = nil, &block)
    severity ||= UNKNOWN
    if severity < @level
      return true
    end
    progname ||= @progname
    if message.nil?
      if block_given?
        message = yield
      else
        message = progname
        progname = @progname
      end
    end
    @logdev.write(
      format_message(format_severity(severity), Time.now, progname, message))
    true
  end
  
  def format_message(severity, time, progname, message)
    if progname
      @headers['application'] = progname
    end

    event = case @type
    when :ng
      $:.push File.expand_path("../flume-ng", __FILE__)
      require 'thrift_source_protocol'

      @headers['host'] = HOST
      @headers['pri'] = severity
      evt = ThriftFlumeEvent.new()
      evt.headers = @headers
      evt.body = message
      evt
    when :og
      $:.push File.expand_path("../flume-og", __FILE__)
      require 'thrift_flume_event_server'  

      evt = ThriftFlumeEvent.new()
      evt.timestamp = time.to_f.to_i * 1000
      evt.priority = PRIORITY[severity]
      evt.body = message
      evt.host = HOST
      evt.nanos = time.usec * 1000
      evt.fields = @headers
      evt
    end
    
    event
  end
end
