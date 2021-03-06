#
# Autogenerated by Thrift Compiler (0.9.0)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'thrift'

module Status
  OK = 0
  FAILED = 1
  ERROR = 2
  UNKNOWN = 3
  VALUE_MAP = {0 => "OK", 1 => "FAILED", 2 => "ERROR", 3 => "UNKNOWN"}
  VALID_VALUES = Set.new([OK, FAILED, ERROR, UNKNOWN]).freeze
end

class ThriftFlumeEvent
  include ::Thrift::Struct, ::Thrift::Struct_Union
  HEADERS = 1
  BODY = 2

  FIELDS = {
    HEADERS => {:type => ::Thrift::Types::MAP, :name => 'headers', :key => {:type => ::Thrift::Types::STRING}, :value => {:type => ::Thrift::Types::STRING}},
    BODY => {:type => ::Thrift::Types::STRING, :name => 'body', :binary => true}
  }

  def struct_fields; FIELDS; end

  def validate
    raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Required field headers is unset!') unless @headers
    raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Required field body is unset!') unless @body
  end

  ::Thrift::Struct.generate_accessors self
end

