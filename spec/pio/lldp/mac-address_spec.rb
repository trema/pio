require File.join( File.dirname( __FILE__ ), "..", "..", "spec_helper" )
require "pio/lldp/mac-address"


module Pio
  class Lldp
    describe MacAddress do
      subject { MacAddress.new( "01:80:c2:00:00:0e" ) }

      its( :to_binary_s ) { should eq [ 0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e ].pack( "C6" ) }
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
