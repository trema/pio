require 'pio/set_ip_address'

describe Pio::SetIpDestinationAddress do
  describe '.new' do
    context "with '1.2.3.4'" do
      When(:set_ip_destination_addr) do
        Pio::SetIpDestinationAddress.new('1.2.3.4')
      end

      describe '#ip_address' do
        Then { set_ip_destination_addr.ip_address == '1.2.3.4' }
      end

      describe '#type' do
        Then { set_ip_destination_addr.type == 7 }
      end

      describe '#message_length' do
        Then { set_ip_destination_addr.message_length == 8 }
      end

      describe '#to_binary' do
        Then { set_ip_destination_addr.to_binary.length == 8 }
      end
    end
  end
end
