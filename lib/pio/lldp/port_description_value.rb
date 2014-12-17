require 'bindata'

module Pio
  class Lldp
    # TLV value field of port description TLV
    class PortDescriptionValue < BinData::Record
      endian :big

      stringz :port_description
    end
  end
end
