class FlumeLogger::Eventserver
  def initialize(host="localhost", port=9090, flume_type=:ng)
    @host = host
    @port = port
    @client = nil
    @type = flume_type 
  end
  
  def write(event)
    begin
      connect unless @client

      @client.append(event)
    rescue => e
      raise
      warn "#{self.class} - #{e.class} - #{e.message}: #{event}"
      close
      @client = nil
    end
  end

  def close
    @client && @transport.close
  rescue => e
    warn "#{self.class} - #{e.class} - #{e.message}"
  end
  
  private
  def connect
    @client = case @type
    when :ng then 
      @transport = Thrift::FramedTransport.new(Thrift::Socket.new(@host, @port))
      protocol = Thrift::CompactProtocol.new(@transport)
      ThriftSourceProtocol::Client.new(protocol)
    when :og then 
      @transport = Thrift::BufferedTransport.new(Thrift::Socket.new(@host, @port))
      protocol = Thrift::BinaryProtocol.new(@transport)
      ThriftFlumeEventServer::Client.new(protocol)
    end
    @transport.open()
  end
end
