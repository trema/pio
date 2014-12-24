require 'pio/set_ip_addr'

describe Pio::SetIpSrcAddr do
  describe '.new' do
    context "with '1.2.3.4'" do
      When(:set_ip_src_addr) { Pio::SetIpSrcAddr.new('1.2.3.4') }

      describe '#ip_address' do
        Then { set_ip_src_addr.ip_address == '1.2.3.4' }
      end

      describe '#type' do
        Then { set_ip_src_addr.type == 6 }
      end

      describe '#message_length' do
        Then { set_ip_src_addr.message_length == 8 }
      end

      describe '#to_binary' do
        Then { set_ip_src_addr.to_binary.length == 8 }
      end
    end
  end
end
