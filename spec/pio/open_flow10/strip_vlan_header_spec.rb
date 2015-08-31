require 'pio/open_flow10/strip_vlan_header'

describe Pio::StripVlanHeader do
  Given(:strip_vlan_header) { Pio::StripVlanHeader.new }

  describe '#action_type' do
    When(:action_type) { strip_vlan_header.action_type }
    Then { action_type == 3 }
  end

  describe '#message_length' do
    When(:message_length) { strip_vlan_header.message_length }
    Then { message_length == 8 }
  end

  describe '#to_binary' do
    When(:binary) { strip_vlan_header.to_binary }
    Then { binary.length == 8 }
  end
end
