require 'bindata'
require 'pio/open_flow/transaction_id'

module Pio
  # OpenFlow message header parser
  class OpenFlowHeaderParser < BinData::Record
    endian :big

    uint8 :ofp_version
    uint8 :message_type
    uint16 :message_length
    transaction_id :transaction_id
    rest :body
  end

  # OpenFlow message header.
  class OfpHeader < BinData::Record
    endian :big

    uint8 :ofp_version, value: :version_value
    virtual assert: -> { ofp_version == version_value }
    uint8 :message_type, value: :message_type_value
    virtual assert: -> { message_type == message_type_value }
    uint16 :message_length, initial_value: -> { length + body_length }
    transaction_id :transaction_id, initial_value: 0

    def length
      8
    end
  end
end
