require 'active_support/core_ext/object/try'
require 'pio/open_flow/message'
require 'pio/open_flow10/packet_in/reason'
require 'pio/parser'

module Pio
  module OpenFlow10
    # OpenFlow 1.0 Packet-In message
    class PacketIn < OpenFlow::Message
      open_flow_header version: 1,
                       type: 10,
                       length: -> { header_length + 10 + raw_data.length }
      uint32 :buffer_id
      uint16 :total_length, initial_value: -> { raw_data.length }
      uint16 :in_port
      reason :reason
      uint8 :padding
      string :raw_data, read_length: -> { length - header_length - 10 }

      def data
        @data ||= Pio::Parser.read(raw_data)
      end

      def lldp?
        data.is_a? Lldp
      end

      def to_ruby
        @format.to_ruby
      end

      # rubocop:disable LineLength
      def self.inspect
        'PacketIn(open_flow_version: uint8, message_type: uint8, message_length: uint16, transaction_id: uint32, buffer_id: uint32, total_length: uint16, in_port: uint16, reason: symbol, raw_data: string)'
      end
      # rubocop:enable LineLength

      # rubocop:disable LineLength
      def inspect
        data_inspection = if raw_data.empty?
                            %(raw_data: "")
                          else
                            %(data: #{data.inspect})
                          end
        %(#<PacketIn open_flow_version: #{version}, message_type: #{type}, message_length: #{_length}, transaction_id: #{Kernel.format('0x%x', transaction_id)}, buffer_id: #{Kernel.format('0x%x', buffer_id)}, total_length: #{total_length}, in_port: #{in_port}, reason: :#{reason}, #{data_inspection}>)
      end
      # rubocop:enable LineLength

      def method_missing(method, *args)
        bindata_value = data.__send__(method, *args)
        bindata_value.try(:snapshot) || bindata_value
      end

      attr_accessor :datapath_id
      alias dpid datapath_id
      alias dpid= datapath_id=
    end
  end
end
