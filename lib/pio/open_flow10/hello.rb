require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.0 Hello message
  class Hello
    # OpenFlow 1.0 Hello message
    class Format < BinData::Record
      extend OpenFlow::Format

      header version: 1, message_type: OpenFlow::HELLO
      string :body
    end

    def self.read(raw_data)
      allocate.tap do |message|
        message.instance_variable_set(:@format, Format.read(raw_data))
      end
    rescue BinData::ValidityError
      raise Pio::ParseError, 'Invalid Hello message.'
    end

    def initialize(user_options = {})
      header_options = OpenFlowHeader::Options.parse(user_options)
      body_options = user_options[:body] || user_options[:user_data] || ''
      @format = Format.new(header: header_options, body: body_options)
    end

    def method_missing(method, *args, &block)
      @format.__send__ method, *args, &block
    end
  end
end
