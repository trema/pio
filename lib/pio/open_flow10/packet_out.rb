require 'pio/open_flow'

# Base module.
module Pio
  # OpenFlow 1.0 Packet-Out message
  class PacketOut < OpenFlow::Message
    # Message body of Packet-Out
    class Body < BinData::Record
      endian :big

      uint32 :buffer_id
      uint16 :in_port
      uint16 :actions_len, initial_value: -> { actions.binary.length }
      actions :actions, length: -> { actions_len }
      rest :raw_data

      def empty?
        false
      end

      def length
        8 + actions_len + raw_data.length
      end
    end

    # OpenFlow 1.0 Flow Mod message format.
    class Format < BinData::Record
      extend OpenFlow::Format

      header version: 1, message_type: OpenFlow::PACKET_OUT
      body :body
    end

    # rubocop:disable MethodLength
    def initialize(user_options = {})
      header_options = OpenFlowHeader::Options.parse(user_options)
      body_options = if user_options.respond_to?(:fetch)
                       user_options.delete :transaction_id
                       user_options.delete :xid
                       dpid = user_options[:dpid]
                       user_options[:datapath_id] = dpid if dpid
                       user_options
                     else
                       ''
                     end
      @format = Format.new(header: header_options, body: body_options)
    end
    # rubocop:enable MethodLength
  end
end
