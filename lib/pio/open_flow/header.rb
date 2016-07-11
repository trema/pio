require 'bindata'
require 'pio/monkey_patch/uint'
require 'pio/open_flow/transaction_id'
require 'pio/open_flow/version'

module Pio
  module OpenFlow
    # OpenFlow message header parser
    class Header < BinData::Record
      endian :big

      version :version
      uint8 :type
      uint16 :message_length
      transaction_id :transaction_id
      rest :body

      def to_bytes
        [version,
         type,
         message_length,
         transaction_id].map(&:to_bytes).join(', ')
      end
    end
  end
end
