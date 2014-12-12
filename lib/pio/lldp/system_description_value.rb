require 'bindata'

module Pio
  class Lldp
    # TLV value field of system description TLV
    class SystemDescriptionValue < BinData::Record
      endian :big

      stringz :system_description
    end
  end
end
