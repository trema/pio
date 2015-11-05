require 'pio'

describe Pio::DHCP do
  Pio::DHCP == Pio::Dhcp
end

describe Pio::Dhcp, '.read' do
  subject { Pio::Dhcp.read(data.pack('C*')) }

  context 'with DHCP Discover frame' do
    let(:data) do
      [
        # Destination MAC Address
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
        # Source MAC Address
        0x24, 0xdb, 0xac, 0x41, 0xe5, 0x5b,
        # Ethernet Type
        0x08, 0x00,
        # IP version and IP Header Length
        0x45,
        # DSCP
        0x00,
        # IP Total Length
        0x01, 0x48,
        # IP Identifier
        0x00, 0x00,
        # IP Flags and IP Fragmentation
        0x00, 0x00,
        # IP TTL
        0x80,
        # IP Protocol
        0x11,
        # IP Header Checksum
        0x39, 0xa6,
        # IP Source Address
        0x00, 0x00, 0x00, 0x00,
        # IP Destination Address
        0xff, 0xff, 0xff, 0xff,
        # UDP Source Port
        0x00, 0x44,
        # UDP Destination Port
        0x00, 0x43,
        # UDP Total Length
        0x01, 0x34,
        # UDP Header Checksum
        0x88, 0x14,
        # Bootp Msg Type
        0x01,
        # Hw Type
        0x01,
        # Hw Address Length
        0x06,
        # Hops
        0x00,
        # Transaction ID
        0xde, 0xad, 0xbe, 0xef,
        # Seconds
        0x00, 0x00,
        # Bootp Flags
        0x00, 0x00,
        # Client IP Address
        0x00, 0x00, 0x00, 0x00,
        # Your IP Address
        0x00, 0x00, 0x00, 0x00,
        # Next Server IP Address
        0x00, 0x00, 0x00, 0x00,
        # Relay Agent IP Address
        0x00, 0x00, 0x00, 0x00,
        # Client MAC Address
        0x24, 0xdb, 0xac, 0x41, 0xe5, 0x5b,
        # Client Hw Address Padding
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Server Host Name
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Boot File Name
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Magic Cookie
        0x63, 0x82, 0x53, 0x63,
        # DHCP Msg Type
        0x35, 0x01, 0x01,
        # Client Identifier
        0x3d, 0x07, 0x01, 0x24, 0xdb, 0xac, 0x41, 0xe5, 0x5b,
        # Requested IP Address
        0x32, 0x04, 0x00, 0x00, 0x00, 0x00,
        # Parameter Lists
        0x37, 0x04, 0x01, 0x03, 0x06, 0x2a,
        # End Option
        0xff,
        # Padding Field
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
      ]
    end

    describe '#class' do
      subject { super().class }
      it { is_expected.to be Pio::Dhcp::Discover }
    end

    describe '#destination_mac' do
      subject { super().destination_mac }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq 'ff:ff:ff:ff:ff:ff' }
      end
    end

    describe '#source_mac' do
      subject { super().source_mac }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '24:db:ac:41:e5:5b' }
      end
    end

    describe '#ether_type' do
      subject { super().ether_type }
      it { is_expected.to eq 2048 }
    end

    describe '#ip_version' do
      subject { super().ip_version }
      it { is_expected.to eq 4 }
    end

    describe '#ip_header_length' do
      subject { super().ip_header_length }
      it { is_expected.to eq 5 }
    end

    describe '#ip_type_of_service' do
      subject { super().ip_type_of_service }
      it { is_expected.to eq 0 }
    end

    describe '#ip_total_length' do
      subject { super().ip_total_length }
      it { is_expected.to eq 328 }
    end

    describe '#ip_identifier' do
      subject { super().ip_identifier }
      it { is_expected.to eq 0x0000 }
    end

    describe '#ip_flag' do
      subject { super().ip_flag }
      it { is_expected.to eq 0 }
    end

    describe '#ip_fragment' do
      subject { super().ip_fragment }
      it { is_expected.to eq 0 }
    end

    describe '#ip_ttl' do
      subject { super().ip_ttl }
      it { is_expected.to eq 128 }
    end

    describe '#ip_protocol' do
      subject { super().ip_protocol }
      it { is_expected.to eq 17 }
    end

    describe '#ip_header_checksum' do
      subject { super().ip_header_checksum }
      it { is_expected.to eq 0x39a6 }
    end

    describe '#source_ip_address' do
      subject { super().source_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#destination_ip_address' do
      subject { super().destination_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '255.255.255.255' }
      end
    end

    describe '#udp_source_port' do
      subject { super().udp_source_port }
      it { is_expected.to eq 68 }
    end

    describe '#udp_destination_port' do
      subject { super().udp_destination_port }
      it { is_expected.to eq 67 }
    end

    describe '#udp_length' do
      subject { super().udp_length }
      it { is_expected.to eq 308 }
    end

    describe '#udp_checksum' do
      subject { super().udp_checksum }
      it { is_expected.to eq 0x8814 }
    end

    describe '#message_type' do
      subject { super().message_type }
      it { is_expected.to eq 1 }
    end

    describe '#hw_addr_type' do
      subject { super().hw_addr_type }
      it { is_expected.to eq 1 }
    end

    describe '#hw_addr_len' do
      subject { super().hw_addr_len }
      it { is_expected.to eq 6 }
    end

    describe '#hops' do
      subject { super().hops }
      it { is_expected.to eq 0 }
    end

    describe '#transaction_id' do
      subject { super().transaction_id }
      it { is_expected.to eq 0xdeadbeef }
    end

    describe '#seconds' do
      subject { super().seconds }
      it { is_expected.to eq 0 }
    end

    describe '#bootp_flags' do
      subject { super().bootp_flags }
      it { is_expected.to eq 0 }
    end

    describe '#client_ip_address' do
      subject { super().client_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#your_ip_address' do
      subject { super().your_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#next_server_ip_address' do
      subject { super().next_server_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#relay_agent_ip_address' do
      subject { super().relay_agent_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#client_mac_address' do
      subject { super().client_mac_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '24:db:ac:41:e5:5b' }
      end
    end

    describe '#client_identifier' do
      subject { super().client_identifier }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '24:db:ac:41:e5:5b' }
      end
    end

    describe '#requested_ip_address' do
      subject { super().requested_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#parameters_list' do
      subject { super().parameters_list }
      it { is_expected.to eq [0x01, 0x03, 0x06, 0x2a] }
    end
  end

  context 'with DHCP offer frame' do
    let(:data) do
      [
        # Destination MAC Address
        0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
        # Source MAC Address
        0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
        # Ethernet Type
        0x08, 0x00,
        # IP version and IP Header Length
        0x45,
        # DSCP
        0x00,
        # IP Total Length
        0x01, 0x48,
        # IP Identifier
        0x00, 0x00,
        # IP Flags and IP Fragmentation
        0x00, 0x00,
        # IP TTL
        0x80,
        # IP Protocol
        0x11,
        # IP Header Checksum
        0xb8, 0x49,
        # IP Source Address
        0xc0, 0xa8, 0x00, 0x0a,
        # IP Destination Address
        0xc0, 0xa8, 0x00, 0x01,
        # UDP Source Port
        0x00, 0x43,
        # UDP Destination Port
        0x00, 0x44,
        # UDP Total Length
        0x01, 0x34,
        # UDP Header Checksum
        0x1e, 0x64,
        # Bootp Msg Type
        0x02,
        # Hw Type
        0x01,
        # Hw Address Length
        0x06,
        # Hops
        0x00,
        # Transaction ID
        0xde, 0xad, 0xbe, 0xef,
        # Seconds
        0x00, 0x00,
        # Bootp Flags
        0x00, 0x00,
        # Client IP Address
        0x00, 0x00, 0x00, 0x00,
        # Your IP Address
        0xc0, 0xa8, 0x00, 0x01,
        # Next Server IP Address
        0x00, 0x00, 0x00, 0x00,
        # Relay Agent IP Address
        0x00, 0x00, 0x00, 0x00,
        # Client MAC Address
        0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
        # Client Hw Address Padding
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Server Host Name
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Boot File Name
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Magic Cookie
        0x63, 0x82, 0x53, 0x63,
        # DHCP Msg Type
        0x35, 0x01, 0x02,
        # Renewal Time Value
        0x3a, 0x04, 0xde, 0xad, 0xbe, 0xef,
        # Rebinding Time Value
        0x3b, 0x04, 0xde, 0xad, 0xbe, 0xef,
        # IP Address Lease Time Value
        0x33, 0x04, 0xde, 0xad, 0xbe, 0xef,
        # DHCP Server Identifier
        0x36, 0x04, 0xc0, 0xa8, 0x00, 0x0a,
        # Subnet Mask
        0x01, 0x04, 0xff, 0xff, 0xff, 0x00,
        # End Option
        0xff,
        # Padding Field
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00
      ]
    end

    describe '#class' do
      subject { super().class }
      it { is_expected.to be Pio::Dhcp::Offer }
    end

    describe '#destination_mac' do
      subject { super().destination_mac }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '11:22:33:44:55:66' }
      end
    end

    describe '#source_mac' do
      subject { super().source_mac }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq 'aa:bb:cc:dd:ee:ff' }
      end
    end

    describe '#ether_type' do
      subject { super().ether_type }
      it { is_expected.to eq 2048 }
    end

    describe '#ip_version' do
      subject { super().ip_version }
      it { is_expected.to eq 4 }
    end

    describe '#ip_header_length' do
      subject { super().ip_header_length }
      it { is_expected.to eq 5 }
    end

    describe '#ip_type_of_service' do
      subject { super().ip_type_of_service }
      it { is_expected.to eq 0 }
    end

    describe '#ip_total_length' do
      subject { super().ip_total_length }
      it { is_expected.to eq 328 }
    end

    describe '#ip_identifier' do
      subject { super().ip_identifier }
      it { is_expected.to eq 0x0000 }
    end

    describe '#ip_flag' do
      subject { super().ip_flag }
      it { is_expected.to eq 0 }
    end

    describe '#ip_fragment' do
      subject { super().ip_fragment }
      it { is_expected.to eq 0 }
    end

    describe '#ip_ttl' do
      subject { super().ip_ttl }
      it { is_expected.to eq 128 }
    end

    describe '#ip_protocol' do
      subject { super().ip_protocol }
      it { is_expected.to eq 17 }
    end

    describe '#ip_header_checksum' do
      subject { super().ip_header_checksum }
      it { is_expected.to eq 0xb849 }
    end

    describe '#source_ip_address' do
      subject { super().source_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '192.168.0.10' }
      end
    end

    describe '#destination_ip_address' do
      subject { super().destination_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '192.168.0.1' }
      end
    end

    describe '#udp_source_port' do
      subject { super().udp_source_port }
      it { is_expected.to eq 67 }
    end

    describe '#udp_destination_port' do
      subject { super().udp_destination_port }
      it { is_expected.to eq 68 }
    end

    describe '#udp_length' do
      subject { super().udp_length }
      it { is_expected.to eq 308 }
    end

    describe '#udp_checksum' do
      subject { super().udp_checksum }
      it { is_expected.to eq 7780 }
    end

    describe '#message_type' do
      subject { super().message_type }
      it { is_expected.to eq 2 }
    end

    describe '#hw_addr_type' do
      subject { super().hw_addr_type }
      it { is_expected.to eq 1 }
    end

    describe '#hw_addr_len' do
      subject { super().hw_addr_len }
      it { is_expected.to eq 6 }
    end

    describe '#hops' do
      subject { super().hops }
      it { is_expected.to eq 0 }
    end

    describe '#transaction_id' do
      subject { super().transaction_id }
      it { is_expected.to eq 0xdeadbeef }
    end

    describe '#seconds' do
      subject { super().seconds }
      it { is_expected.to eq 0 }
    end

    describe '#bootp_flags' do
      subject { super().bootp_flags }
      it { is_expected.to eq 0x0000 }
    end

    describe '#client_ip_address' do
      subject { super().client_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#your_ip_address' do
      subject { super().your_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '192.168.0.1' }
      end
    end

    describe '#next_server_ip_address' do
      subject { super().next_server_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#relay_agent_ip_address' do
      subject { super().relay_agent_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#client_mac_address' do
      subject { super().client_mac_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq 'aa:bb:cc:dd:ee:ff' }
      end
    end

    describe '#server_identifier' do
      subject { super().server_identifier }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '192.168.0.10' }
      end
    end

    describe '#subnet_mask' do
      subject { super().subnet_mask }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '255.255.255.0' }
      end
    end

    describe '#renewal_time_value' do
      subject { super().renewal_time_value }
      it { is_expected.to eq 0xdeadbeef }
    end

    describe '#rebinding_time_value' do
      subject { super().rebinding_time_value }
      it { is_expected.to eq 0xdeadbeef }
    end

    describe '#ip_address_lease_time' do
      subject { super().ip_address_lease_time }
      it { is_expected.to eq 0xdeadbeef }
    end
  end

  context 'with DHCP Request frame' do
    let(:data) do
      [
        # Destination MAC Address
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
        # Source MAC Address
        0x24, 0xdb, 0xac, 0x41, 0xe5, 0x5b,
        # Ethernet Type
        0x08, 0x00,
        # IP version and IP Header Length
        0x45,
        # DSCP
        0x00,
        # IP Total Length
        0x01, 0x48,
        # IP Identifier
        0x00, 0x00,
        # IP Flags and IP Fragmentation
        0x00, 0x00,
        # IP TTL
        0x80,
        # IP Protocol
        0x11,
        # IP Header Checksum
        0x39, 0xa6,
        # IP Source Address
        0x00, 0x00, 0x00, 0x00,
        # IP Destination Address
        0xff, 0xff, 0xff, 0xff,
        # UDP Source Port
        0x00, 0x44,
        # UDP Destination Port
        0x00, 0x43,
        # UDP Total Length
        0x01, 0x34,
        # UDP Header Checksum
        0xce, 0xb3,
        # Bootp Msg Type
        0x01,
        # Hw Type
        0x01,
        # Hw Address Length
        0x06,
        # Hops
        0x00,
        # Transaction ID
        0xde, 0xad, 0xbe, 0xef,
        # Seconds
        0x00, 0x00,
        # Bootp Flags
        0x00, 0x00,
        # Client IP Address
        0x00, 0x00, 0x00, 0x00,
        # Your IP Address
        0x00, 0x00, 0x00, 0x00,
        # Next Server IP Address
        0x00, 0x00, 0x00, 0x00,
        # Relay Agent IP Address
        0x00, 0x00, 0x00, 0x00,
        # Client MAC Address
        0x24, 0xdb, 0xac, 0x41, 0xe5, 0x5b,
        # Client Hw Address Padding
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Server Host Name
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Boot File Name
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Magic Cookie
        0x63, 0x82, 0x53, 0x63,
        # DHCP Msg Type
        0x35, 0x01, 0x03,
        # Client Identifier
        0x3d, 0x07, 0x01, 0x24, 0xdb, 0xac, 0x41, 0xe5, 0x5b,
        # Requested IP Address
        0x32, 0x04, 0xc0, 0xa8, 0x00, 0x0a,
        # Parameter Lists
        0x37, 0x04, 0x01, 0x03, 0x06, 0x2a,
        # DHCP Server Identifier
        0x36, 0x04, 0xc0, 0xa8, 0x00, 0x01,
        # End Option
        0xff,
        # Padding Field
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00
      ]
    end

    describe '#class' do
      subject { super().class }
      it { is_expected.to be Pio::Dhcp::Request }
    end

    describe '#destination_mac' do
      subject { super().destination_mac }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq 'ff:ff:ff:ff:ff:ff' }
      end
    end

    describe '#source_mac' do
      subject { super().source_mac }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '24:db:ac:41:e5:5b' }
      end
    end

    describe '#ether_type' do
      subject { super().ether_type }
      it { is_expected.to eq 2048 }
    end

    describe '#ip_version' do
      subject { super().ip_version }
      it { is_expected.to eq 4 }
    end

    describe '#ip_header_length' do
      subject { super().ip_header_length }
      it { is_expected.to eq 5 }
    end

    describe '#ip_type_of_service' do
      subject { super().ip_type_of_service }
      it { is_expected.to eq 0 }
    end

    describe '#ip_total_length' do
      subject { super().ip_total_length }
      it { is_expected.to eq 328 }
    end

    describe '#ip_identifier' do
      subject { super().ip_identifier }
      it { is_expected.to eq 0x0000 }
    end

    describe '#ip_flag' do
      subject { super().ip_flag }
      it { is_expected.to eq 0 }
    end

    describe '#ip_fragment' do
      subject { super().ip_fragment }
      it { is_expected.to eq 0 }
    end

    describe '#ip_ttl' do
      subject { super().ip_ttl }
      it { is_expected.to eq 128 }
    end

    describe '#ip_protocol' do
      subject { super().ip_protocol }
      it { is_expected.to eq 17 }
    end

    describe '#ip_header_checksum' do
      subject { super().ip_header_checksum }
      it { is_expected.to eq 0x39a6 }
    end

    describe '#source_ip_address' do
      subject { super().source_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#destination_ip_address' do
      subject { super().destination_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '255.255.255.255' }
      end
    end

    describe '#udp_source_port' do
      subject { super().udp_source_port }
      it { is_expected.to eq 68 }
    end

    describe '#udp_destination_port' do
      subject { super().udp_destination_port }
      it { is_expected.to eq 67 }
    end

    describe '#udp_length' do
      subject { super().udp_length }
      it { is_expected.to eq 308 }
    end

    describe '#udp_checksum' do
      subject { super().udp_checksum }
      it { is_expected.to eq 0xceb3 }
    end

    describe '#message_type' do
      subject { super().message_type }
      it { is_expected.to eq 3 }
    end

    describe '#hw_addr_type' do
      subject { super().hw_addr_type }
      it { is_expected.to eq 1 }
    end

    describe '#hw_addr_len' do
      subject { super().hw_addr_len }
      it { is_expected.to eq 6 }
    end

    describe '#hops' do
      subject { super().hops }
      it { is_expected.to eq 0 }
    end

    describe '#transaction_id' do
      subject { super().transaction_id }
      it { is_expected.to eq 0xdeadbeef }
    end

    describe '#seconds' do
      subject { super().seconds }
      it { is_expected.to eq 0 }
    end

    describe '#bootp_flags' do
      subject { super().bootp_flags }
      it { is_expected.to eq 0 }
    end

    describe '#client_ip_address' do
      subject { super().client_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#your_ip_address' do
      subject { super().your_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#next_server_ip_address' do
      subject { super().next_server_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#relay_agent_ip_address' do
      subject { super().relay_agent_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#client_mac_address' do
      subject { super().client_mac_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '24:db:ac:41:e5:5b' }
      end
    end

    describe '#client_identifier' do
      subject { super().client_identifier }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '24:db:ac:41:e5:5b' }
      end
    end

    describe '#requested_ip_address' do
      subject { super().requested_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '192.168.0.10' }
      end
    end

    describe '#parameters_list' do
      subject { super().parameters_list }
      it { is_expected.to eq [0x01, 0x03, 0x06, 0x2a] }
    end
  end

  context 'with DHCP ACK frame' do
    let(:data) do
      [
        # Destination MAC Address
        0x11, 0x22, 0x33, 0x44, 0x55, 0x66,
        # Source MAC Address
        0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
        # Ethernet Type
        0x08, 0x00,
        # IP version and IP Header Length
        0x45,
        # DSCP
        0x00,
        # IP Total Length
        0x01, 0x48,
        # IP Identifier
        0x00, 0x00,
        # IP Flags and IP Fragmentation
        0x00, 0x00,
        # IP TTL
        0x80,
        # IP Protocol
        0x11,
        # IP Header Checksum
        0xb8, 0x49,
        # IP Source Address
        0xc0, 0xa8, 0x00, 0x0a,
        # IP Destination Address
        0xc0, 0xa8, 0x00, 0x01,
        # UDP Source Port
        0x00, 0x43,
        # UDP Destination Port
        0x00, 0x44,
        # UDP Total Length
        0x01, 0x34,
        # UDP Header Checksum
        0x1b, 0x64,
        # Bootp Msg Type
        0x02,
        # Hw Type
        0x01,
        # Hw Address Length
        0x06,
        # Hops
        0x00,
        # Transaction ID
        0xde, 0xad, 0xbe, 0xef,
        # Seconds
        0x00, 0x00,
        # Bootp Flags
        0x00, 0x00,
        # Client IP Address
        0x00, 0x00, 0x00, 0x00,
        # Your IP Address
        0xc0, 0xa8, 0x00, 0x01,
        # Next Server IP Address
        0x00, 0x00, 0x00, 0x00,
        # Relay Agent IP Address
        0x00, 0x00, 0x00, 0x00,
        # Client MAC Address
        0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
        # Client Hw Address Padding
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Server Host Name
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Boot File Name
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        # Magic Cookie
        0x63, 0x82, 0x53, 0x63,
        # DHCP Msg Type
        0x35, 0x01, 0x05,
        # Renewal Time Value
        0x3a, 0x04, 0xde, 0xad, 0xbe, 0xef,
        # Rebinding Time Value
        0x3b, 0x04, 0xde, 0xad, 0xbe, 0xef,
        # IP Address Lease Time Value
        0x33, 0x04, 0xde, 0xad, 0xbe, 0xef,
        # DHCP Server Identifier
        0x36, 0x04, 0xc0, 0xa8, 0x00, 0x0a,
        # Subnet Mask
        0x01, 0x04, 0xff, 0xff, 0xff, 0x00,
        # End Option
        0xff,
        # Padding Field
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00
      ]
    end

    describe '#class' do
      subject { super().class }
      it { is_expected.to be Pio::Dhcp::Ack }
    end

    describe '#destination_mac' do
      subject { super().destination_mac }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '11:22:33:44:55:66' }
      end
    end

    describe '#source_mac' do
      subject { super().source_mac }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq 'aa:bb:cc:dd:ee:ff' }
      end
    end

    describe '#ether_type' do
      subject { super().ether_type }
      it { is_expected.to eq 2048 }
    end

    describe '#ip_version' do
      subject { super().ip_version }
      it { is_expected.to eq 4 }
    end

    describe '#ip_header_length' do
      subject { super().ip_header_length }
      it { is_expected.to eq 5 }
    end

    describe '#ip_type_of_service' do
      subject { super().ip_type_of_service }
      it { is_expected.to eq 0 }
    end

    describe '#ip_total_length' do
      subject { super().ip_total_length }
      it { is_expected.to eq 328 }
    end

    describe '#ip_identifier' do
      subject { super().ip_identifier }
      it { is_expected.to eq 0x0000 }
    end

    describe '#ip_flag' do
      subject { super().ip_flag }
      it { is_expected.to eq 0 }
    end

    describe '#ip_fragment' do
      subject { super().ip_fragment }
      it { is_expected.to eq 0 }
    end

    describe '#ip_ttl' do
      subject { super().ip_ttl }
      it { is_expected.to eq 128 }
    end

    describe '#ip_protocol' do
      subject { super().ip_protocol }
      it { is_expected.to eq 17 }
    end

    describe '#ip_header_checksum' do
      subject { super().ip_header_checksum }
      it { is_expected.to eq 0xb849 }
    end

    describe '#source_ip_address' do
      subject { super().source_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '192.168.0.10' }
      end
    end

    describe '#destination_ip_address' do
      subject { super().destination_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '192.168.0.1' }
      end
    end

    describe '#udp_source_port' do
      subject { super().udp_source_port }
      it { is_expected.to eq 67 }
    end

    describe '#udp_destination_port' do
      subject { super().udp_destination_port }
      it { is_expected.to eq 68 }
    end

    describe '#udp_length' do
      subject { super().udp_length }
      it { is_expected.to eq 308 }
    end

    describe '#udp_checksum' do
      subject { super().udp_checksum }
      it { is_expected.to eq 0x1b64 }
    end

    describe '#message_type' do
      subject { super().message_type }
      it { is_expected.to eq 5 }
    end

    describe '#hw_addr_type' do
      subject { super().hw_addr_type }
      it { is_expected.to eq 1 }
    end

    describe '#hw_addr_len' do
      subject { super().hw_addr_len }
      it { is_expected.to eq 6 }
    end

    describe '#hops' do
      subject { super().hops }
      it { is_expected.to eq 0 }
    end

    describe '#transaction_id' do
      subject { super().transaction_id }
      it { is_expected.to eq 0xdeadbeef }
    end

    describe '#seconds' do
      subject { super().seconds }
      it { is_expected.to eq 0 }
    end

    describe '#bootp_flags' do
      subject { super().bootp_flags }
      it { is_expected.to eq 0x0000 }
    end

    describe '#client_ip_address' do
      subject { super().client_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#your_ip_address' do
      subject { super().your_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '192.168.0.1' }
      end
    end

    describe '#next_server_ip_address' do
      subject { super().next_server_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#relay_agent_ip_address' do
      subject { super().relay_agent_ip_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '0.0.0.0' }
      end
    end

    describe '#client_mac_address' do
      subject { super().client_mac_address }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq 'aa:bb:cc:dd:ee:ff' }
      end
    end

    describe '#server_identifier' do
      subject { super().server_identifier }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '192.168.0.10' }
      end
    end

    describe '#subnet_mask' do
      subject { super().subnet_mask }
      describe '#to_s' do
        subject { super().to_s }
        it { is_expected.to eq '255.255.255.0' }
      end
    end

    describe '#renewal_time_value' do
      subject { super().renewal_time_value }
      it { is_expected.to eq 0xdeadbeef }
    end

    describe '#rebinding_time_value' do
      subject { super().rebinding_time_value }
      it { is_expected.to eq 0xdeadbeef }
    end

    describe '#ip_address_lease_time' do
      subject { super().ip_address_lease_time }
      it { is_expected.to eq 0xdeadbeef }
    end
  end
end
