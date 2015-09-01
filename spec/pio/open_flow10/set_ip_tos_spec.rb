require 'pio/open_flow10/set_ip_tos'

describe Pio::SetIpTos do
  describe '.new' do
    context 'with 32' do
      When(:set_ip_tos) { Pio::SetIpTos.new(32) }

      describe '#type_of_service' do
        Then { set_ip_tos.type_of_service == 32 }
      end

      describe '#action_type' do
        Then { set_ip_tos.action_type == 8 }
      end

      describe '#message_length' do
        Then { set_ip_tos.message_length == 8 }
      end

      describe '#to_binary' do
        Then { set_ip_tos.to_binary.length == 8 }
      end
    end

    context 'with 1' do
      When(:set_ip_tos) { Pio::SetIpTos.new(1) }
      Then { set_ip_tos == Failure(ArgumentError) }
    end
  end
end
