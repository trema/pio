require 'bindata'
require 'pio/open_flow/transaction_id'

module Pio
  module OpenFlow
    # OpenFlow message header parser
    class OpenFlowHeaderParser < BinData::Record
      endian :big

      uint8 :_version
      uint8 :type
      uint16 :message_length
      transaction_id :transaction_id
      rest :body

      def version
        { 1 => :OpenFlow10, 4 => :OpenFlow13 }.fetch(_version)
      end
    end

    # OpenFlow message header.
    class OfpHeader < BinData::Record
      endian :big

      uint8 :version, value: :version_value
      virtual assert: -> { version == version_value }
      uint8 :type, value: :message_type_value
      virtual assert: -> { message_type == message_type_value }
      uint16 :_length, initial_value: -> { length + body_length }
      transaction_id :transaction_id, initial_value: 0

      def length
        8
      end
    end
  end
  OpenFlowHeaderParser = OpenFlow::OpenFlowHeaderParser
end
