require 'bindata'
require 'pio/open_flow'

module Pio
  # OpenFlow 1.0 Packet-Out message
  class PacketOut < OpenFlow::Message.factory(OpenFlow::Type::PACKET_OUT)
    # Message body of Packet-Out
    class PacketOutBody < BinData::Record
      endian :big

      uint32 :buffer_id
      uint16 :in_port
      uint16 :actions_len, initial_value: -> { actions.binary.length }
      actions :actions, length: -> { actions_len }
      rest :data

      def empty?
        false
      end

      def length
        8 + actions_len + data.length
      end
    end

    def_delegators :body, :buffer_id
    def_delegators :body, :in_port
    def_delegators :body, :actions_len
    def_delegators :body, :actions
    def_delegators :body, :data
  end
end
