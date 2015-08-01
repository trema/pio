require 'pio/open_flow10/match'

describe Pio::OpenFlow10::Match do
  describe '.read' do
    When(:match) { Pio::OpenFlow10::Match.read(binary) }

    context 'with a Match binary' do
      Given(:binary) do
        [
          0x00, 0x38, 0x20, 0xfe,
          0x00, 0x01,
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
          0x00, 0x00,
          0x00,
          0x00,
          0x00, 0x00,
          0x00,
          0x00,
          0x00, 0x00,
          0x00, 0x00, 0x00, 0x00,
          0x00, 0x00, 0x00, 0x00,
          0x00, 0x00,
          0x00, 0x00
        ].pack('C*')
      end

      Then do
        match.wildcards.keys == [
          :vlan_vid,
          :ether_source_address,
          :ether_destination_address,
          :ether_type,
          :ip_protocol,
          :transport_source_port,
          :transport_destination_port,
          :ip_source_address_all,
          :ip_destination_address_all,
          :vlan_priority,
          :ip_tos
        ]
      end
      Then { match.in_port == 1 }
      Then { match.ether_source_address == '00:00:00:00:00:00' }
      Then { match.ether_destination_address == '00:00:00:00:00:00' }
      Then { match.vlan_vid == 0 }
      Then { match.vlan_priority == 0 }
      Then { match.ether_type == 0 }
      Then { match.ip_tos == 0 }
      Then { match.ip_protocol == 0 }
      Then { match.ip_source_address == '0.0.0.0' }
      Then { match.ip_destination_address == '0.0.0.0' }
      Then { match.transport_source_port == 0 }
      Then { match.transport_destination_port == 0 }
    end

    context 'with a Match binary generated with Pio::OpenFlow10::Match.new' do
      Given(:binary) do
        Pio::OpenFlow10::Match
          .new(ip_source_address: '192.168.1.0/24')
          .to_binary_s
      end

      Then do
        match.wildcards.keys == [
          :in_port,
          :vlan_vid,
          :ether_source_address,
          :ether_destination_address,
          :ether_type,
          :ip_protocol,
          :transport_source_port,
          :transport_destination_port,
          :ip_source_address,
          :ip_destination_address_all,
          :vlan_priority,
          :ip_tos
        ]
      end
      And { match.wildcards[:ip_source_address] = 12 }
      Then { match.in_port == 0 }
      Then { match.ether_source_address == '00:00:00:00:00:00' }
      Then { match.ether_destination_address == '00:00:00:00:00:00' }
      Then { match.vlan_vid == 0 }
      Then { match.vlan_priority == 0 }
      Then { match.ether_type == 0 }
      Then { match.ip_tos == 0 }
      Then { match.ip_protocol == 0 }
      Then { match.ip_source_address == '192.168.1.0' }
      Then { match.ip_source_address.prefixlen == 24 }
      Then { match.ip_destination_address == '0.0.0.0' }
      Then { match.transport_source_port == 0 }
      Then { match.transport_destination_port == 0 }
    end
  end

  describe '.new' do
    When(:match) { Pio::OpenFlow10::Match.new(options) }

    context 'with in_port: 1' do
      Given(:options) { { in_port: 1 } }
      Then do
        match.wildcards.keys == [
          :vlan_vid,
          :ether_source_address,
          :ether_destination_address,
          :ether_type,
          :ip_protocol,
          :transport_source_port,
          :transport_destination_port,
          :ip_source_address_all,
          :ip_destination_address_all,
          :vlan_priority,
          :ip_tos
        ]
      end
      Then { match.in_port == 1 }
      Then { match.ether_source_address == '00:00:00:00:00:00' }
      Then { match.ether_destination_address == '00:00:00:00:00:00' }
      Then { match.vlan_vid == 0 }
      Then { match.vlan_priority == 0 }
      Then { match.ether_type == 0 }
      Then { match.ip_tos == 0 }
      Then { match.ip_protocol == 0 }
      Then { match.ip_source_address == '0.0.0.0' }
      Then { match.ip_destination_address == '0.0.0.0' }
      Then { match.transport_source_port == 0 }
      Then { match.transport_destination_port == 0 }

      describe '#==' do
        When(:result) { match == other }

        context 'with Match.new(in_port: 1)' do
          Given(:other) { Pio::OpenFlow10::Match.new(in_port: 1) }
          Then { result == true }
        end
      end
    end

    context "with ip_source_address: '192.168.1.0/24'" do
      Given(:options) { { ip_source_address: '192.168.1.0/24' } }
      Then do
        match.wildcards.keys == [
          :in_port,
          :vlan_vid,
          :ether_source_address,
          :ether_destination_address,
          :ether_type,
          :ip_protocol,
          :transport_source_port,
          :transport_destination_port,
          :ip_source_address,
          :ip_destination_address_all,
          :vlan_priority,
          :ip_tos
        ]
      end
      Then { match.wildcards.fetch(:ip_source_address) == 8 }
      Then { match.in_port == 0 }
      Then { match.ether_source_address == '00:00:00:00:00:00' }
      Then { match.ether_destination_address == '00:00:00:00:00:00' }
      Then { match.vlan_vid == 0 }
      Then { match.vlan_priority == 0 }
      Then { match.ether_type == 0 }
      Then { match.ip_tos == 0 }
      Then { match.ip_protocol == 0 }
      Then { match.ip_source_address == '192.168.1.0/24' }
      Then { match.ip_destination_address == '0.0.0.0' }
      Then { match.transport_source_port == 0 }
      Then { match.transport_destination_port == 0 }
    end

    context "with ip_destination_address: '192.168.1.0/24'" do
      Given(:options) { { ip_destination_address: '192.168.1.0/24' } }
      Then do
        match.wildcards.keys == [
          :in_port,
          :vlan_vid,
          :ether_source_address,
          :ether_destination_address,
          :ether_type,
          :ip_protocol,
          :transport_source_port,
          :transport_destination_port,
          :ip_source_address_all,
          :ip_destination_address,
          :vlan_priority,
          :ip_tos
        ]
      end
      Then { match.wildcards.fetch(:ip_destination_address) == 8 }
      Then { match.in_port == 0 }
      Then { match.ether_source_address == '00:00:00:00:00:00' }
      Then { match.ether_destination_address == '00:00:00:00:00:00' }
      Then { match.vlan_vid == 0 }
      Then { match.vlan_priority == 0 }
      Then { match.ether_type == 0 }
      Then { match.ip_tos == 0 }
      Then { match.ip_protocol == 0 }
      Then { match.ip_source_address == '0.0.0.0' }
      Then { match.ip_destination_address == '192.168.1.0/24' }
      Then { match.transport_source_port == 0 }
      Then { match.transport_destination_port == 0 }
    end
  end
end
