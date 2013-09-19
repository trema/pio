require "rubygems"
require "bindata"


module Pio
  class Lldp
    # The V of Organizationally specfic TLV.
    class OrganizationallySpecificValue < BinData::Record
      endian :big

      uint24be :oui
      uint8 :subtype
      stringz :information
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
