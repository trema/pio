require 'bindata'
require 'pio/enqueue'
require 'pio/open_flow'
require 'pio/send_out_port'
require 'pio/set_eth_addr'
require 'pio/set_ip_addr'
require 'pio/set_ip_tos'
require 'pio/set_transport_port'
require 'pio/set_vlan_priority'
require 'pio/set_vlan_vid'
require 'pio/strip_vlan_header'

module Pio
  # OpenFlow 1.0 Packet-Out message
  class PacketOut < Pio::OpenFlow::Message
    # Actions list.
    class Actions < BinData::Primitive
      ACTION_CLASS = {
        0 => Pio::SendOutPort,
        1 => Pio::SetVlanVid,
        2 => Pio::SetVlanPriority,
        3 => Pio::StripVlanHeader,
        4 => Pio::SetEthSrcAddr,
        5 => Pio::SetEthDstAddr,
        6 => Pio::SetIpSrcAddr,
        7 => Pio::SetIpDstAddr,
        8 => Pio::SetIpTos,
        9 => Pio::SetTransportSrcPort,
        10 => Pio::SetTransportDstPort,
        11 => Pio::Enqueue
      }

      endian :big

      uint16 :actions_len, initial_value: -> { binary.length }
      string :binary, read_length: :actions_len

      def set(value)
        self.binary = [value].flatten.map(&:to_binary).join
      end

      # rubocop:disable MethodLength
      # This method smells of :reek:TooManyStatements
      def get
        actions = []
        tmp = binary
        while tmp.length > 0
          type = BinData::Uint16be.read(tmp)
          begin
            action = ACTION_CLASS.fetch(type).read(tmp)
            tmp = tmp[action.message_length..-1]
            actions << action
          rescue KeyError
            raise "action type #{type} is not supported."
          end
        end
        actions
      end
      # rubocop:enable MethodLength

      def [](index)
        get[index]
      end
    end

    # Message body of Packet-Out
    class Body < BinData::Record
      endian :big

      uint32 :buffer_id
      uint16 :in_port
      actions :actions
      rest :data

      def empty?
        false
      end

      def length
        8 + actions_len + data.length
      end

      def actions_len
        actions.actions_len
      end
    end

    def_format Pio::OpenFlow::Type::PACKET_OUT

    def self.read(raw_data)
      packet_out = allocate
      packet_out.instance_variable_set :@format, Format.read(raw_data)
      packet_out
    end

    def_delegators :body, :buffer_id
    def_delegators :body, :in_port
    def_delegators :body, :actions_len
    def_delegators :body, :actions
    def_delegators :body, :data
  end
end
