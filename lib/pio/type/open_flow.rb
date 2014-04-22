# encoding: utf-8

require 'bindata'

module Pio
  module Type
    # OpenFlow 1.0 format.
    module OpenFlow
      def openflow_header
        class_eval do
          uint8 :version, value: 1
          uint8 :message_type
          uint16 :message_length, initial_value: -> { 8 + body.length }
          uint32 :transaction_id, initial_value: 0
        end
      end

      # Description of a physical port
      class PhyPort < BinData::Record
        endian :big

        uint16 :port_no
        uint8 :hw_addr
        stringz :name, read_length: 16
        uint32 :config
        uint32 :state
        uint32 :curr
        uint32 :advertised
        uint32 :supported
        uint32 :peer
      end
    end
  end
end
