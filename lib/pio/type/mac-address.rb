require "bindata"
require "pio/mac"


module Pio
  module Type
    # MAC address
    class MacAddress < BinData::Primitive
      array :octets, :type => :uint8, :initial_length => 6


      def set value
        self.octets = value
      end


      def get
        Mac.new( octets.inject( "" ) { | str, each | str + ( "%02x" % each ) }.hex )
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
