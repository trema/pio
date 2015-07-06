require 'forwardable'
require 'pio/open_flow'

# Base module.
module Pio
  remove_const :Echo

  module Echo
    # Base class of Echo Request and Reply.
    class Message
      def self.message_name
        name.split('::')[1..-1].map { |each| each.gsub(/\d+$/, '') }.join(' ')
      end

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format,
                                        const_get(:Format).read(raw_data))
        end
      rescue BinData::ValidityError
        raise Pio::ParseError, "Invalid #{message_name} 1.3 message."
      end

      def initialize(user_attrs = {})
        unknown_attrs = user_attrs.keys - [:transaction_id, :xid, :body]
        unless unknown_attrs.empty?
          fail "Unknown keyword: #{unknown_attrs.first}"
        end
        header_options = OpenFlowHeader::Options.parse(user_attrs)
        @format =
          self.class.const_get(:Format).new(header: header_options,
                                            body: user_attrs[:body])
      end

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end
    end

    # OpenFlow 1.3 Echo Request message.
    class Request < Message
      # OpenFlow 1.3 Echo Request message format.
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 4, message_type: 2
        string :body, read_length: -> { message_length - 8 }
      end
    end

    # OpenFlow 1.3 Echo Reply message.
    class Reply < Message
      # OpenFlow 1.3 Echo Request message format.
      class Format < BinData::Record
        extend OpenFlow::Format

        header version: 4, message_type: 3
        string :body, read_length: -> { message_length - 8 }
      end
    end
  end
end
