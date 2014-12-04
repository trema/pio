# encoding: utf-8

require 'bindata'

module Pio
  module Type
    # OpenFlow 1.0 format.
    module OpenFlow
      # OpenFlow 1.0 message header format.
      class OpenFlowHeader < BinData::Record
        endian :big

        uint8 :ofp_version, value: 1
        uint8 :message_type, initial_value: :message_type_value
        uint16 :message_length, initial_value: -> { 8 + body.length }
        uint32 :transaction_id, initial_value: 0
      end
    end
  end
end
