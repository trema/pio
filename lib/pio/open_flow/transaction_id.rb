require 'bindata'
require 'pio/monkey_patch/integer'

module Pio
  module OpenFlow
    # Transaction ID (uint32)
    class TransactionId < BinData::Primitive
      endian :big

      uint32 :xid

      def set(value)
        unless value.unsigned_32bit?
          fail(ArgumentError,
               'Transaction ID should be an unsigned 32-bit integer.')
        end
        self.xid = value
      end

      def get
        xid
      end
    end
  end
end
