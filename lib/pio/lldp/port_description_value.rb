require "rubygems"
require "bindata"


module Pio
  class Lldp
    # TLV value field of port description TLV
    class PortDescriptionValue < BinData::Record
      endian :big

      stringz :port_description
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
