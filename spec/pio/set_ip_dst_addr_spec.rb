require 'pio/set_ip_addr'

describe Pio::SetIpDstAddr do
  describe '.new' do
    context "with '1.2.3.4'" do
      When(:set_ip_dst_addr) { Pio::SetIpDstAddr.new('1.2.3.4') }

      describe '#ip_address' do
        Then { set_ip_dst_addr.ip_address == '1.2.3.4' }
      end

      describe '#type' do
        Then { set_ip_dst_addr.type == 7 }
      end

      describe '#message_length' do
        Then { set_ip_dst_addr.message_length == 8 }
      end

      describe '#to_binary' do
        Then { set_ip_dst_addr.to_binary.length == 8 }
      end
    end
  end
end
