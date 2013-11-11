require "pio"


module Pio
  describe Lldp do
    context ".new" do
      subject {
        Lldp.new(
          :dpid => dpid,
          :port_number => port_number,
          :source_mac => source_mac,
          :destination_mac => destination_mac
        )
      }


      context "with :dpid and :port_number" do
        let( :dpid ) { 108173701773 }
        let( :port_number ) { 1 }
        let( :source_mac ) { nil }
        let( :destination_mac ) { nil }
        let( :lldp_dump ) {
          [
           0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e,  # Destination MAC
           0x01, 0x02, 0x03, 0x04, 0x05, 0x06,  # Source MAC
           0x88, 0xcc,  # Ethertype
           0x02, 0x09, 0x07, 0x00, 0x00, 0x00, 0x19, 0x2f, 0xa7, 0xb2, 0x8d,  # Chassis ID TLV
           0x04, 0x05, 0x07, 0x00, 0x00, 0x00, 0x01,  # Port ID TLV
           0x06, 0x02, 0x00, 0x78,  # Time to live TLV
           0x00, 0x00,  # End of LLDPDU TLV
           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,   # Padding
           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
           0x00, 0x00
          ]
        }

        context "#to_binary" do
          it "returns an LLDP binary string" do
            expect( subject.to_binary.unpack( "C*" ) ).to eq lldp_dump
          end

          it "returns a valid ether frame with size = 64" do
            expect( subject.to_binary.size ).to eq 64
          end
        end
      end


      context "with :dpid, :port_number and :source_mac" do
        let( :dpid ) { 108173701773 }
        let( :port_number ) { 1 }
        let( :source_mac ) { "06:05:04:03:02:01" }
        let( :destination_mac ) { nil }
        let( :lldp_dump ) {
          [
           0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e,  # Destination MAC
           0x06, 0x05, 0x04, 0x03, 0x02, 0x01,  # Source MAC
           0x88, 0xcc,  # Ethertype
           0x02, 0x09, 0x07, 0x00, 0x00, 0x00, 0x19, 0x2f, 0xa7, 0xb2, 0x8d,  # Chassis ID TLV
           0x04, 0x05, 0x07, 0x00, 0x00, 0x00, 0x01,  # Port ID TLV
           0x06, 0x02, 0x00, 0x78,  # Time to live TLV
           0x00, 0x00,  # End of LLDPDU TLV
           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,   # Padding
           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
           0x00, 0x00
          ]
        }

        context "#to_binary" do
          it "returns an LLDP binary string" do
            expect( subject.to_binary.unpack( "C*" ) ).to eq lldp_dump
          end

          it "returns a valid ether frame with size = 64" do
            expect( subject.to_binary.size ).to eq 64
          end
        end
      end


      context "with :dpid, :port_number, :source_mac and :destination_mac" do
        let( :dpid ) { 108173701773 }
        let( :port_number ) { 1 }
        let( :source_mac ) { "06:05:04:03:02:01" }
        let( :destination_mac ) { "01:02:03:04:05:06" }
        let( :lldp_dump ) {
          [
           0x01, 0x02, 0x03, 0x04, 0x05, 0x06,  # Destination MAC
           0x06, 0x05, 0x04, 0x03, 0x02, 0x01,  # Source MAC
           0x88, 0xcc,  # Ethertype
           0x02, 0x09, 0x07, 0x00, 0x00, 0x00, 0x19, 0x2f, 0xa7, 0xb2, 0x8d,  # Chassis ID TLV
           0x04, 0x05, 0x07, 0x00, 0x00, 0x00, 0x01,  # Port ID TLV
           0x06, 0x02, 0x00, 0x78,  # Time to live TLV
           0x00, 0x00,  # End of LLDPDU TLV
           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,   # Padding
           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
           0x00, 0x00
          ]
        }

        context "#to_binary" do
          it "returns an LLDP binary string" do
            expect( subject.to_binary.unpack( "C*" ) ).to eq lldp_dump
          end

          it "returns a valid ether frame with size = 64" do
            expect( subject.to_binary.size ).to eq 64
          end
        end
      end


      context "when :dpid is not set" do
        let( :dpid ) { nil }
        let( :port_number ) { 1 }
        let( :source_mac ) { nil }
        let( :destination_mac ) { nil }

        it { expect { subject }.to raise_error( "Invalid DPID: nil" ) }
      end


      context "when :port_number is not set" do
        let( :dpid ) { 108173701773 }
        let( :port_number ) { nil }
        let( :source_mac ) { nil }
        let( :destination_mac ) { nil }

        it { expect { subject }.to raise_error( "Invalid port number: nil" ) }
      end
    end


    context ".read" do
      subject { Lldp.read( data.pack( "C*" ) ) }

      context "with a minimal LLDP frame" do
        let( :data ) {
          [
           0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e,  # Destination MAC
           0x00, 0x19, 0x2f, 0xa7, 0xb2, 0x8d,  # Source MAC
           0x88, 0xcc,  # Ethertype
           0x02, 0x07, 0x04, 0x00, 0x19, 0x2f, 0xa7, 0xb2, 0x8d,  # Chassis ID TLV
           0x04, 0x0d, 0x01, 0x55, 0x70, 0x6c, 0x69, 0x6e, 0x6b, 0x20, 0x74, 0x6f, 0x20, 0x53, 0x31,  # Port ID TLV
           0x06, 0x02, 0x00, 0x78,  # Time to live TLV
           0x00, 0x00  # End of LLDPDU TLV
          ]
        }

        its( "destination_mac.to_s" ) { should eq "01:80:c2:00:00:0e" }
        its( "source_mac.to_s" ) { should eq "00:19:2f:a7:b2:8d" }
        its( :ether_type ) { should eq 0x88cc }
        its( :dpid ) { should eq 108173701773 }
        its( 'dpid.class' ) { should eq Fixnum }
        its( :chassis_id ) { should eq 108173701773 }
        its( :port_id ) { should eq "Uplink to S1" }
        its( :port_number ) { should eq "Uplink to S1" }
        its( :ttl ) { should eq 120 }
        its( :port_description ) { should be_nil }
        its( :system_name ) { should be_nil }
        its( :system_description ) { should be_nil }
        its( :system_capabilities ) { should be_nil }
        its( :management_address ) { should be_nil }
      end


      context "with a detailed LLDP frame" do
        let( :data ) {
          [
           0x01, 0x80, 0xc2, 0x00, 0x00, 0x0e,  # Destination MAC
           0x00, 0x19, 0x2f, 0xa7, 0xb2, 0x8d,  # Source MAC
           0x88, 0xcc,  # Ethertype
           0x02, 0x07, 0x04, 0x00, 0x19, 0x2f, 0xa7, 0xb2, 0x8d,  # Chassis ID TLV
           0x04, 0x0d, 0x01, 0x55, 0x70, 0x6c, 0x69, 0x6e, 0x6b, 0x20, 0x74, 0x6f, 0x20, 0x53, 0x31,  # Port ID TLV
           0x06, 0x02, 0x00, 0x78,  # Time to live TLV
           0x08, 0x17, 0x53, 0x75, 0x6d, 0x6d, 0x69, 0x74, 0x33, 0x30, 0x30, 0x2d, 0x34, 0x38, 0x2d, 0x50, 0x6f, 0x72, 0x74, 0x20, 0x31, 0x30, 0x30, 0x31, 0x00,  # Port Description
           0x0a, 0x0d, 0x53, 0x75, 0x6d, 0x6d, 0x69, 0x74, 0x33, 0x30, 0x30, 0x2d, 0x34, 0x38, 0x00,  # System Name
           0x0c, 0x4c, 0x53, 0x75, 0x6d, 0x6d, 0x69, 0x74, 0x33, 0x30, 0x30, 0x2d, 0x34, 0x38, 0x20, 0x2d, 0x20, 0x56, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x20, 0x37, 0x2e, 0x34, 0x65, 0x2e, 0x31, 0x20, 0x28, 0x42, 0x75, 0x69, 0x6c, 0x64, 0x20, 0x35, 0x29, 0x20, 0x62, 0x79, 0x20, 0x52, 0x65, 0x6c, 0x65, 0x61, 0x73, 0x65, 0x5f, 0x4d, 0x61, 0x73, 0x74, 0x65, 0x72, 0x20, 0x30, 0x35, 0x2f, 0x32, 0x37, 0x2f, 0x30, 0x35, 0x20, 0x30, 0x34, 0x3a, 0x35, 0x33, 0x3a, 0x31, 0x31, 0x00,  # System Description
           0x0e, 0x04, 0x00, 0x14, 0x00, 0x14, # System Capabilities
           0x10, 0x0e, 0x07, 0x06, 0x00, 0x01, 0x30, 0xf9, 0xad, 0xa0, 0x02, 0x00, 0x00, 0x03, 0xe9, 0x00, # Management Address
           0xfe, 0x07, 0x00, 0x12, 0x0f, 0x02, 0x07, 0x01, 0x00, # Organizationally Specific
           0x00, 0x00  # End of LLDPDU TLV
          ]
        }

        its( "destination_mac.to_s" ) { should eq "01:80:c2:00:00:0e" }
        its( "source_mac.to_s" ) { should eq "00:19:2f:a7:b2:8d" }
        its( :ether_type ) { should eq 0x88cc }
        its( :dpid ) { should eq 108173701773 }
        its( :chassis_id ) { should eq 108173701773 }
        its( :port_id ) { should eq "Uplink to S1" }
        its( :port_number ) { should eq "Uplink to S1" }
        its( :ttl ) { should eq 120 }
        its( :port_description ) { should eq "Summit300-48-Port 1001" }
        its( :system_name ) { should eq "Summit300-48" }
        its( :system_description ) { should eq "Summit300-48 - Version 7.4e.1 (Build 5) by Release_Master 05/27/05 04:53:11" }
        its( "system_capabilities.system_capabilities" ) { should eq 20 }
        its( "system_capabilities.enabled_capabilities" ) { should eq 20 }
        its( :management_address ) { should eq [ 0x00, 0x01, 0x30, 0xf9, 0xad, 0xa0 ].pack( "C*" ) }
        its( "organizationally_specific.oui" ) { should eq 4623 }
        its( "organizationally_specific.subtype" ) { should eq 2 }
        its( "organizationally_specific.information" ) { should eq "\a\x01" }
      end


      context "with an invalid Lldp frame" do
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
