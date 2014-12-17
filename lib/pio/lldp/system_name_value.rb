require 'bindata'

module Pio
  class Lldp
    # TLV value field of system name TLV
    class SystemNameValue < BinData::Record
      endian :big

      stringz :system_name
    end
  end
end
