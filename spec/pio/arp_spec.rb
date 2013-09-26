require "pio"


module Pio
  describe Arp do
    context ".read" do
      subject { Arp.read( data.pack( "C*" ) ) }

      context "with an ARP Request packet" do
        let( :data ) {
          [
           0xff, 0xff, 0xff, 0xff, 0xff, 0xff, # destination mac address
           0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # source mac address
           0x08, 0x06,                         # ethernet type
           0x00, 0x01,                         # arp hardware type
           0x08, 0x00,                         # arp protocol type
           0x06,                               # hardware address size
           0x04,                               # protocol address size
           0x00, 0x01,                         # operational code
           0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # sender hardware address
           0xc0, 0xa8, 0x53, 0x03,             # sender protocol address
           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, # target hardware address
           0xc0, 0xa8, 0x53, 0xfe,             # target protocol address
          ]
        }

        its( :class ) { should be Arp::Request }
        its( "destination_mac.to_s" ) { should eq "ff:ff:ff:ff:ff:ff" }
        its( "source_mac.to_s" ) { should eq "00:26:82:eb:ea:d1" }
        its( :ether_type ) { should eq 0x0806 }
        its( :hardware_type ) { should eq 1 }
        its( :protocol_type ) { should eq 0x800 }
        its( :hardware_length ) { should eq 6 }
        its( :protocol_length ) { should eq 4 }
        its( :operation ) { should eq 1 }
        its( "sender_hardware_address.to_s" ) { should eq "00:26:82:eb:ea:d1" }
        its( "sender_protocol_address.to_s" ) { should eq "192.168.83.3" }
        its( "target_hardware_address.to_s" ) { should eq "00:00:00:00:00:00" }
        its( "target_protocol_address.to_s" ) { should eq "192.168.83.254" }
      end


      context "with an ARP Reply packet" do
        let( :data ) {
          [
           0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # destination mac address
           0x00, 0x16, 0x9d, 0x1d, 0x9c, 0xc4, # source mac address
           0x08, 0x06,                         # ethernet type
           0x00, 0x01,                         # arp hardware type
           0x08, 0x00,                         # arp protocol type
           0x06,                               # hardware address size
           0x04,                               # protocol address size
           0x00, 0x02,                         # operational code
           0x00, 0x16, 0x9d, 0x1d, 0x9c, 0xc4, # sender hardware address
           0xc0, 0xa8, 0x53, 0xfe,             # sender protocol address
           0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # target hardware address
           0xc0, 0xa8, 0x53, 0x03,             # target protocol address
          ]
        }

        its( :class ) { should be Arp::Reply }
        its( "destination_mac.to_s" ) { should eq "00:26:82:eb:ea:d1" }
        its( "source_mac.to_s" ) { should eq "00:16:9d:1d:9c:c4" }
        its( :ether_type ) { should eq 0x0806 }
        its( :hardware_type ) { should eq 1 }
        its( :protocol_type ) { should eq 0x800 }
        its( :hardware_length ) { should eq 6 }
        its( :protocol_length ) { should eq 4 }
        its( :operation ) { should eq 2 }
        its( "sender_hardware_address.to_s" ) { should eq "00:16:9d:1d:9c:c4" }
        its( "sender_protocol_address.to_s" ) { should eq "192.168.83.254" }
        its( "target_hardware_address.to_s" ) { should eq "00:26:82:eb:ea:d1" }
        its( "target_protocol_address.to_s" ) { should eq "192.168.83.3" }
      end


      context "with an ARP Request captured in real environment" do
        let( :data ) {
          [
           0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x5c, 0x9a, 0xd8, 0xea,
           0x37, 0x32, 0x08, 0x06, 0x00, 0x01, 0x08, 0x00, 0x06, 0x04,
           0x00, 0x01, 0x5c, 0x9a, 0xd8, 0xea, 0x37, 0x32, 0xc0, 0xa8,
           0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0xa8,
           0x00, 0xfe
          ]
          it { expect { subject }.not_to raise_error }
        }
      end


      context "with an ARP Request from a real OpenFlow switch" do
        let( :data ) {
          [
           0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x11, 0x22, 0x33, 0x44,
           0x55, 0x66, 0x08, 0x06, 0x00, 0x01, 0x08, 0x00, 0x06, 0x04,
           0x00, 0x01, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0xc0, 0xa8,
           0x00, 0xfe, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xc0, 0xa8,
           0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
           0x00, 0x00, 0x00, 0x00
          ]
          it { expect { subject }.not_to raise_error }
        }
      end


      context "with an ARP Reply captured in real environment" do
        let( :data ) {
          [
           0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x5c, 0x9a, 0xd8, 0xea,
           0x37, 0x32, 0x08, 0x06, 0x00, 0x01, 0x08, 0x00, 0x06, 0x04,
           0x00, 0x02, 0x5c, 0x9a, 0xd8, 0xea, 0x37, 0x32, 0xc0, 0xa8,
           0x00, 0x01, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0xc0, 0xa8,
           0x00, 0xfe
          ]
          it { expect { subject }.not_to raise_error }
        }
      end


      context "with an invalid ARP packet" do
        let( :data ) { [] }

        it { expect { subject }.to raise_error( Pio::ParseError ) }
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
