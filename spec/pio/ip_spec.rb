require File.join( File.dirname( __FILE__ ), "..", "spec_helper" )
require "pio/ip"


module Pio
  describe IP do
    context ".new" do
      subject { IP.new( ip_address, prefixlen ) }


      context %{with "192.168.1.1", 32} do
        let( :ip_address ) { "192.168.1.1" }
        let( :prefixlen ) { 32 }

        its( :to_s ) { should eq "192.168.1.1" }
        its( :to_i ) { should eq 3232235777 }
        its( :to_a ) { should eq [ 0xc0, 0xa8, 0x01, 0x01 ] }
      end


      context %{with "10.1.1.1", 8} do
        let( :ip_address ) { "10.1.1.1" }
        let( :prefixlen ) { 8 }

        its( :to_s ) { should eq "10.0.0.0" }
        its( :to_i ) { should eq 10 * 256 * 256 * 256 }
        its( :to_a ) { should eq [ 0x0a, 0x00, 0x00, 0x00 ] }
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
