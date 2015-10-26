require 'pio/open_flow10/set_ip_address'

describe Pio::OpenFlow10::SetIpSourceAddress do
  describe '.new' do
    context "with '1.2.3.4'" do
      When(:set_ip_source_addr) do
        Pio::OpenFlow10::SetIpSourceAddress.new('1.2.3.4')
      end

      describe '#ip_address' do
        Then { set_ip_source_addr.ip_address == '1.2.3.4' }
      end

      describe '#action_type' do
        Then { set_ip_source_addr.action_type == 6 }
      end

      describe '#length' do
        Then { set_ip_source_addr.length == 8 }
      end

      describe '#to_binary' do
        Then { set_ip_source_addr.to_binary.length == 8 }
      end
    end
  end
end
