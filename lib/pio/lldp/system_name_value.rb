require "rubygems"
require "bindata"


module Pio
  class Lldp
    # TLV value field of system name TLV
    class SystemNameValue < BinData::Record
      endian :big

      stringz :system_name
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
