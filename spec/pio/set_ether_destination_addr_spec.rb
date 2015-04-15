require 'pio/set_ether_addr'

describe Pio::SetEtherDestinationAddr do
  describe '.new' do
    Given(:set_ether_destination_addr) do
      Pio::SetEtherDestinationAddr.new(mac_address)
    end

    context "with '11:22:33:44:55:66'" do
      When(:mac_address) { '11:22:33:44:55:66' }
      Then { set_ether_destination_addr.mac_address == '11:22:33:44:55:66' }

      describe '#to_binary' do
        Then { set_ether_destination_addr.to_binary.length == 16 }
      end
    end

    context 'with 0x112233445566' do
      When(:mac_address) { 0x112233445566 }
      Then { set_ether_destination_addr.mac_address == '11:22:33:44:55:66' }
    end

    context "with Pio::Mac.new('11:22:33:44:55:66')" do
      When(:mac_address) { Pio::Mac.new('11:22:33:44:55:66') }
      Then { set_ether_destination_addr.mac_address == '11:22:33:44:55:66' }
    end
  end
end
