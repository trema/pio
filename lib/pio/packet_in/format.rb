require 'bindata'
require 'pio/open_flow'

module Pio
  class PacketIn < Pio::OpenFlow::Message
    # Message body of Packet-In.
    class Body < BinData::Record
      def empty?
        false
      end
    end

    # OpenFlow 1.0 Packet-In message parser and generator.
    class Format < BinData::Record
      include Pio::OpenFlow::Type

      endian :big

      open_flow_header :open_flow_header, message_type_value: PACKET_IN
      body :body
    end
  end
end
