require "pio/ipv4_address"


module Pio
  describe IPv4Address do
    context ".new" do
      subject( :ipv4 ) { IPv4Address.new( ip_address ) }


      context "with 10.1.1.1" do
        let( :ip_address ) { "10.1.1.1" }

        its( :to_s ) { should eq "10.1.1.1" }
        its( :to_i ) { should eq ( ( ( 10 * 256 + 1 ) * 256 + 1 ) * 256 + 1 ) }
        its( :prefixlen ) { should eq 32 }
        its( :to_ary ) { should eq [ 0x0a, 0x01, 0x01, 0x01 ] }
        its( :class_a? ) { should be_true }
        its( :class_b? ) { should be_false }
        its( :class_c? ) { should be_false }
        its( :class_d? ) { should be_false }
        its( :class_e? ) { should be_false }
        its( :unicast? ) { should be_true }
        its( :multicast? ) { should be_false }


        context ".mask!" do
          subject { ipv4.mask!( mask ) }

          let( :mask ) { 8 }

          its( :to_s ) { should eq "10.0.0.0" }
          its( :to_i ) { should eq 10 * 256 * 256 * 256 }
          its( :to_ary ) { should eq [ 0x0a, 0x00, 0x00, 0x00 ] }
          its( :class_a? ) { should be_true }
          its( :class_b? ) { should be_false }
          its( :class_c? ) { should be_false }
          its( :class_d? ) { should be_false }
          its( :class_e? ) { should be_false }
          its( :unicast? ) { should be_true }
          its( :multicast? ) { should be_false }
        end
      end


      context "with 172.20.1.1" do
        let( :ip_address ) { "172.20.1.1" }

        its( :to_s ) { should eq "172.20.1.1" }
        its( :to_i ) { should eq ( ( ( 172 * 256 + 20 ) * 256 + 1 ) * 256 + 1 ) }
        its( :to_ary ) { should eq [ 0xac, 0x14, 0x01, 0x01 ] }
        its( :class_a? ) { should be_false }
        its( :class_b? ) { should be_true }
        its( :class_c? ) { should be_false }
        its( :class_d? ) { should be_false }
        its( :class_e? ) { should be_false }
        its( :unicast? ) { should be_true }
        its( :multicast? ) { should be_false }
      end


      context "with 192.168.1.1" do
        let( :ip_address ) { "192.168.1.1" }

        its( :to_s ) { should eq "192.168.1.1" }
        its( :to_i ) { should eq 3232235777 }
        its( :to_ary ) { should eq [ 0xc0, 0xa8, 0x01, 0x01 ] }
        its( :class_a? ) { should be_false }
        its( :class_b? ) { should be_false }
        its( :class_c? ) { should be_true }
        its( :class_d? ) { should be_false }
        its( :class_e? ) { should be_false }
        its( :unicast? ) { should be_true }
        its( :multicast? ) { should be_false }
      end


      context "with 234.1.1.1" do
        let( :ip_address ) { "234.1.1.1" }

        its( :to_s ) { should eq "234.1.1.1" }
        its( :to_i ) { should eq ( ( ( 234 * 256 + 1 ) * 256 + 1 ) * 256 + 1 ) }
        its( :to_ary ) { should eq [ 0xea, 0x01, 0x01, 0x01 ] }
        its( :class_a? ) { should be_false }
        its( :class_b? ) { should be_false }
        its( :class_c? ) { should be_false }
        its( :class_d? ) { should be_true }
        its( :class_e? ) { should be_false }
        its( :unicast? ) { should be_false }
        its( :multicast? ) { should be_true }
      end


      context "with 192.168.0.1/16" do
        let( :ip_address ) { "192.168.0.1/16" }

        its( :prefixlen ) { should eq 16 }
      end


      context "with 192.168.0.1/255.255.255.0" do
        let( :ip_address ) { "192.168.0.1/255.255.255.0" }

        its( :prefixlen ) { should eq 24 }
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
