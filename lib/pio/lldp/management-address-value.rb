require "rubygems"
require "bindata"


module Pio
  class Lldp
    # TLV value field of management address TLV
    class ManagementAddressValue < BinData::Record
      endian :big

      stringz :management_address
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
