require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Echo Request and Reply message.
  module Echo
    # OpenFlow 1.0 Echo Request message.
    class Request; end
    OpenFlow::Message.factory(Request, OpenFlow::ECHO_REQUEST)

    # OpenFlow 1.0 Echo Reply message.
    class Reply; end
    OpenFlow::Message.factory(Reply, OpenFlow::ECHO_REPLY)
  end

  module Echo13
    # OpenFlow 1.3 Echo Request message.
    class Request
      # OpenFlow 1.3 Echo Request message format.
      class Format < BinData::Record
        endian :big

        uint8 :ofp_version, initial_value: 4
        uint8 :message_type, value: 2
        uint16 :message_length, initial_value: :echo_message_length
        transaction_id :transaction_id
        string :body, read_length: -> { message_length - 8 }

        def xid
          transaction_id
        end

        private

        def echo_message_length
          8 + body.length
        end
      end

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Format.read(raw_data))
        end
      end

      def initialize(user_attrs = {})
        attrs = user_attrs.dup
        attrs[:transaction_id] = attrs.fetch(:xid) if attrs.key?(:xid)
        @format = Format.new(attrs)
      end

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end
    end

    # OpenFlow 1.3 Echo Reply message.
    class Reply
      # OpenFlow 1.3 Echo Request message format.
      class Format < BinData::Record
        endian :big

        uint8 :ofp_version, initial_value: 4
        uint8 :message_type, value: 3
        uint16 :message_length, initial_value: :echo_message_length
        transaction_id :transaction_id
        string :body, read_length: -> { message_length - 8 }

        def xid
          transaction_id
        end

        private

        def echo_message_length
          8 + body.length
        end
      end

      def self.read(raw_data)
        allocate.tap do |message|
          message.instance_variable_set(:@format, Format.read(raw_data))
        end
      end

      def initialize(user_attrs = {})
        attrs = user_attrs.dup
        attrs[:transaction_id] = attrs.fetch(:xid) if attrs.key?(:xid)
        @format = Format.new(attrs)
      end

      def method_missing(method, *args, &block)
        @format.__send__ method, *args, &block
      end
    end
  end
end
