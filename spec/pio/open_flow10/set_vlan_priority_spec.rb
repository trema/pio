require 'pio/open_flow10/set_vlan_priority'

describe Pio::OpenFlow10::SetVlanPriority do
  describe '.new' do
    When(:set_vlan_priority) { Pio::OpenFlow10::SetVlanPriority.new(priority) }

    context 'with 3' do
      When(:priority) { 3 }

      describe '#vlan_priority' do
        Then { set_vlan_priority.vlan_priority == 3 }
      end

      describe '#action_type' do
        Then { set_vlan_priority.action_type == 2 }
      end

      describe '#action_length' do
        Then { set_vlan_priority.action_length == 8 }
      end

      describe '#to_binary' do
        Then { set_vlan_priority.to_binary.length == 8 }
      end
    end

    context 'with -1' do
      When(:priority) { -1 }
      Then { set_vlan_priority == Failure(ArgumentError) }
    end

    context 'with 8' do
      When(:priority) { 8 }
      Then { set_vlan_priority == Failure(ArgumentError) }
    end

    context 'with :INVALID_PRIORITY' do
      When(:priority) { :INVALID_PRIORITY }
      Then { set_vlan_priority == Failure(TypeError) }
    end
  end
end
