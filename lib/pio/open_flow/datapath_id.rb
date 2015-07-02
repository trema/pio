require 'bindata'
require 'pio/monkey_patch/integer'

module Pio
  module OpenFlow
    # Datapath unique ID. The lower 48-bits are for a MAC address,
    # while the upper 16-bits are implementer-defined.
    class DatapathId < BinData::Primitive
      endian :big

      uint64 :datapath_id

      def set(value)
        unless value.unsigned_64bit?
          fail(ArgumentError,
               'Datapath ID should be an unsigned 64-bit integer.')
        end
        self.datapath_id = value
      end

      def get
        datapath_id
      end
    end
  end
end
