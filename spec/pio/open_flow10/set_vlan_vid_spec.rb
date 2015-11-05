require 'pio/open_flow10/set_vlan_vid'

describe Pio::OpenFlow10::SetVlanVid do
  describe '.new' do
    When(:set_vlan_vid) { Pio::OpenFlow10::SetVlanVid.new(vlan_id) }

    context 'with 10' do
      When(:vlan_id) { 10 }

      describe '#vlan_id' do
        Then { set_vlan_vid.vlan_id == 10 }
      end

      describe '#action_type' do
        Then { set_vlan_vid.action_type == 1 }
      end

      describe '#action_length' do
        Then { set_vlan_vid.action_length == 8 }
      end

      describe '#to_binary' do
        Then { set_vlan_vid.to_binary.length == 8 }
      end
    end

    context 'with 0' do
      When(:vlan_id) { 0 }
      Then { set_vlan_vid == Failure(ArgumentError) }
    end

    context 'with 4906' do
      When(:vlan_id) { 4096 }
      Then { set_vlan_vid == Failure(ArgumentError) }
    end

    context 'with :INVALID_VLAN_ID' do
      When(:vlan_id) { :INVALID_VLAN_ID }
      Then { set_vlan_vid == Failure(TypeError) }
    end
  end
end
