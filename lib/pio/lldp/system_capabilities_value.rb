require "rubygems"
require "bindata"


module Pio
  class Lldp
    # TLV value field of system capabilities TLV
    class SystemCapabilitiesValue < BinData::Record
      endian :big

      uint16be :system_capabilities
      uint16be :enabled_capabilities
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
