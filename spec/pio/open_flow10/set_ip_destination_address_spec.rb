require 'pio/open_flow10/set_ip_address'

describe Pio::OpenFlow10::SetIpDestinationAddress do
  describe '.new' do
    context "with '1.2.3.4'" do
      When(:set_ip_destination_addr) do
        Pio::OpenFlow10::SetIpDestinationAddress.new('1.2.3.4')
      end

      describe '#ip_address' do
        Then { set_ip_destination_addr.ip_address == '1.2.3.4' }
      end

      describe '#action_type' do
        Then { set_ip_destination_addr.action_type == 7 }
      end

      describe '#action_length' do
        Then { set_ip_destination_addr.action_length == 8 }
      end

      describe '#to_binary' do
        Then { set_ip_destination_addr.to_binary.length == 8 }
      end
    end
  end
end
