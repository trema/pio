require 'bindata'

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
