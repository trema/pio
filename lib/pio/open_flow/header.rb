require 'bindata'
require 'pio/open_flow/transaction_id'

module Pio
  module OpenFlow
    # OpenFlow message header parser
    class Header < BinData::Record
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
  end
end
