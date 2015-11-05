require 'pio/open_flow10/flow_mod'

describe Pio::OpenFlow10::FlowMod do
  Given(:dump) do
    [
      0x01,
      0x0e,
      0x00, 0x50,
      0x00, 0x00, 0x00, 0x15,
      0x00, 0x38, 0x20, 0xfe, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
      0x00, 0x00,
      0x00, 0x00,
      0x00, 0x00,
      0xff, 0xff,
      0xff, 0xff, 0xff, 0xff,
      0x00, 0x02,
      0x00, 0x03,
      0x00, 0x00, 0x00, 0x08, 0x00, 0x02, 0xff, 0xff
    ].pack('C*')
  end

  describe '.read' do
    context 'with a flow_mod message' do
      When(:flow_mod) do
        Pio::OpenFlow10::FlowMod.read(dump)
      end

      Then { flow_mod.class == Pio::OpenFlow10::FlowMod }
      Then { flow_mod.ofp_version == 0x1 }
      Then { flow_mod.message_type == 0xe }
      Then { flow_mod.message_length == 0x50 }
      Then { flow_mod.transaction_id == 0x15 }
      Then { flow_mod.xid == 0x15 }

      Then do
        flow_mod.match.wildcards.keys == [
          :vlan_vid,
          :source_mac_address,
          :destination_mac_address,
          :ether_type,
          :ip_protocol,
          :transport_source_port,
          :transport_destination_port,
          :source_ip_address_all,
          :destination_ip_address_all,
          :vlan_priority,
          :tos
        ]
      end
      Then { flow_mod.match.in_port == 1 }
      Then { flow_mod.match.source_mac_address == '00:00:00:00:00:00' }
      Then { flow_mod.match.destination_mac_address == '00:00:00:00:00:00' }
      Then { flow_mod.match.vlan_vid == 0 }
      Then { flow_mod.match.vlan_priority == 0 }
      Then { flow_mod.match.ether_type == 0 }
      Then { flow_mod.match.tos == 0 }
      Then { flow_mod.match.ip_protocol == 0 }
      Then { flow_mod.match.source_ip_address == '0.0.0.0' }
      Then { flow_mod.match.destination_ip_address == '0.0.0.0' }
      Then { flow_mod.match.transport_source_port == 0 }
      Then { flow_mod.match.transport_destination_port == 0 }
      Then { flow_mod.cookie == 1 }
      Then { flow_mod.command == :add }
      Then { flow_mod.idle_timeout == 0 }
      Then { flow_mod.hard_timeout == 0 }
      Then { flow_mod.priority == 0xffff }
      Then { flow_mod.buffer_id == 0xffffffff }
      Then { flow_mod.out_port == 2 }
      Then { flow_mod.flags == [:send_flow_rem, :check_overwrap] }
      Then { flow_mod.actions.length == 1 }
      Then { flow_mod.actions[0].is_a? Pio::OpenFlow10::SendOutPort }
      Then { flow_mod.actions[0].port == 2 }
      Then { flow_mod.actions[0].max_length == 2**16 - 1 }
    end
  end

  describe '.new' do
    context 'with a SendOutPort action' do
      When(:flow_mod) do
        Pio::OpenFlow10::FlowMod.new(
          transaction_id: 0x15,
          buffer_id: 0xffffffff,
          match: Pio::OpenFlow10::Match.new(in_port: 1),
          cookie: 1,
          command: :add,
          priority: 0xffff,
          out_port: 2,
          flags: [:send_flow_rem, :check_overwrap],
          actions: Pio::OpenFlow10::SendOutPort.new(2)
        )
      end

      Then { flow_mod.class == Pio::OpenFlow10::FlowMod }
      Then { flow_mod.ofp_version == 0x1 }
      Then { flow_mod.message_type == 0xe }
      Then { flow_mod.message_length == 0x50 }
      Then { flow_mod.transaction_id == 0x15 }
      Then { flow_mod.xid == 0x15 }

      Then do
        flow_mod.match.wildcards.keys == [
          :vlan_vid,
          :source_mac_address,
          :destination_mac_address,
          :ether_type,
          :ip_protocol,
          :transport_source_port,
          :transport_destination_port,
          :source_ip_address_all,
          :destination_ip_address_all,
          :vlan_priority,
          :tos
        ]
      end
      Then { flow_mod.match.in_port == 1 }
      Then { flow_mod.match.source_mac_address == '00:00:00:00:00:00' }
      Then { flow_mod.match.destination_mac_address == '00:00:00:00:00:00' }
      Then { flow_mod.match.vlan_vid == 0 }
      Then { flow_mod.match.vlan_priority == 0 }
      Then { flow_mod.match.ether_type == 0 }
      Then { flow_mod.match.tos == 0 }
      Then { flow_mod.match.ip_protocol == 0 }
      Then { flow_mod.match.source_ip_address == '0.0.0.0' }
      Then { flow_mod.match.destination_ip_address == '0.0.0.0' }
      Then { flow_mod.match.transport_source_port == 0 }
      Then { flow_mod.match.transport_destination_port == 0 }
      Then { flow_mod.cookie == 1 }
      Then { flow_mod.command == :add }
      Then { flow_mod.idle_timeout == 0 }
      Then { flow_mod.hard_timeout == 0 }
      Then { flow_mod.priority == 0xffff }
      Then { flow_mod.buffer_id == 0xffffffff }
      Then { flow_mod.out_port == 2 }
      Then { flow_mod.flags == [:send_flow_rem, :check_overwrap] }
      Then { flow_mod.actions.length == 1 }
      Then { flow_mod.actions[0].is_a? Pio::OpenFlow10::SendOutPort }
      Then { flow_mod.actions[0].port == 2 }
      Then { flow_mod.actions[0].max_length == 2**16 - 1 }

      context '#to_binary' do
        When(:binary) { flow_mod.to_binary }
        Then { binary == dump }
      end
    end
  end
end
