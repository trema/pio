require 'forwardable'
require 'pio/open_flow'
require 'pio/open_flow10/message'

module Pio
  # OpenFlow 1.0 Echo Request and Reply message.
  module Echo
    # OpenFlow 1.0 Echo Request message.
    class Request
      # OpenFlow 1.0 Hello message
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 1, message_type: OpenFlow::ECHO_REQUEST
        string :body

        def user_data
          body
        end
      end

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Format.read(raw_data))
        end
      rescue BinData::ValidityError
        raise Pio::ParseError, 'Invalid Echo Request message.'
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

    # OpenFlow 1.0 Echo Reply message.
    class Reply
      # OpenFlow 1.0 Hello message
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 1, message_type: OpenFlow::ECHO_REPLY
        string :body

        def user_data
          body
        end
      end

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Format.read(raw_data))
        end
      rescue BinData::ValidityError
        raise Pio::ParseError, 'Invalid Echo Reply message.'
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
end
