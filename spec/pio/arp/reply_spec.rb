require "pio/arp/reply"


module Pio
  class Arp
    describe Reply do
      context ".new" do
        subject {
          Arp::Reply.new(
            :source_mac => source_mac,
            :destination_mac => destination_mac,
            :sender_protocol_address => sender_protocol_address,
            :target_protocol_address => target_protocol_address
          )
        }

        let( :arp_reply_dump ) {
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
           0x00, 0x00, 0x00, 0x00, 0x00, 0x00, # padding
           0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
           0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
           0x00, 0x00, 0x00, 0x00,
          ].pack( "C*" )
        }


        context "with Integer MAC and IP address" do
          let( :source_mac ) { 0x00169d1d9cc4 }
          let( :destination_mac ) { 0x002682ebead1 }
          let( :sender_protocol_address ) { 0xc0a853fe }
          let( :target_protocol_address ) { 0xc0a85303 }

          context "#to_binary" do
            it "returns an Arp Reply binary String" do
              expect( subject.to_binary ).to eq arp_reply_dump
            end

            it "returns a valid ether frame with size = 64" do
              expect( subject.to_binary.size ).to eq 64
            end
          end
        end


        context "with String MAC and Integer IP address" do
          let( :source_mac ) { "00:16:9d:1d:9c:c4" }
          let( :destination_mac ) { "00:26:82:eb:ea:d1" }
          let( :sender_protocol_address ) { 0xc0a853fe }
          let( :target_protocol_address ) { 0xc0a85303 }

          context "#to_binary" do
            it "returns an Arp Reply binary String" do
              expect( subject.to_binary ).to eq arp_reply_dump
            end

            it "returns a valid ether frame with size = 64" do
              expect( subject.to_binary.size ).to eq 64
            end
          end
        end


        context "when Integer MAC and String IP address" do
          let( :source_mac ) { 0x00169d1d9cc4 }
          let( :destination_mac ) { 0x002682ebead1 }
          let( :sender_protocol_address ) { "192.168.83.254" }
          let( :target_protocol_address ) { "192.168.83.3" }

          context "#to_binary" do
            it "returns an Arp Reply binary String" do
              expect( subject.to_binary ).to eq arp_reply_dump
            end

            it "returns a valid ether frame with size = 64" do
              expect( subject.to_binary.size ).to eq 64
            end
          end
        end


        context "when :source_mac is not set" do
          let( :source_mac ) { nil }
          let( :destination_mac ) { 0x002682ebead1 }
          let( :sender_protocol_address ) { "192.168.83.3" }
          let( :target_protocol_address ) { "192.168.83.254" }

          it "raises an invalid MAC address error" do
            expect { subject }.to raise_error( "Invalid MAC address: nil" )
          end
        end


        context "when :destination_mac is not set" do
          let( :source_mac ) { 0x00169d1d9cc4 }
          let( :destination_mac ) { nil }
          let( :sender_protocol_address ) { "192.168.83.3" }
          let( :target_protocol_address ) { "192.168.83.254" }

          it "raises an invalid MAC address error" do
            expect { subject }.to raise_error( "Invalid MAC address: nil" )
          end
        end


        context "when :sender_protocol_address is not set" do
          let( :source_mac ) { 0x00169d1d9cc4 }
          let( :destination_mac ) { 0x002682ebead1 }
          let( :sender_protocol_address ) { nil }
          let( :target_protocol_address ) { "192.168.83.254" }

          it "raises an invalid IPv4 address error" do
            expect { subject }.to raise_error( "Invalid IPv4 address: nil" )
          end
        end


        context "when :target_protocol_address is not set" do
          let( :source_mac ) { 0x00169d1d9cc4 }
          let( :destination_mac ) { 0x002682ebead1 }
          let( :sender_protocol_address ) { "192.168.83.3" }
          let( :target_protocol_address ) { nil }

          it "raises an invalid IPv4 address error" do
            expect { subject }.to raise_error( "Invalid IPv4 address: nil" )
          end
        end
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
