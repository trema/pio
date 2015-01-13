require 'pio/echo'

describe Pio::Echo do
  describe '.read' do
    When(:result) { Pio::Echo.read binary }

    context 'with an Echo Request message' do
      Given(:binary) { [1, 2, 0, 8, 0, 0, 0, 0].pack('C*') }

      Then { result.class == Pio::Echo::Request }
      Then { result.ofp_version == 1 }
      Then { result.message_type == Pio::OpenFlow::Type::ECHO_REQUEST }
      Then { result.message_length == 8 }
      Then { result.xid == 0 }
      Then { result.user_data == '' }
      Then { result.to_binary == binary }
    end

    context 'with an Echo Reply message' do
      Given(:binary) { [1, 3, 0, 8, 0, 0, 0, 0].pack('C*') }

      Then { result.class == Pio::Echo::Reply }
      Then { result.ofp_version == 1 }
      Then { result.message_type == Pio::OpenFlow::Type::ECHO_REPLY }
      Then { result.message_length == 8 }
      Then { result.xid == 0 }
      Then { result.user_data == '' }
      Then { result.to_binary == binary }
    end

    context 'with a Features Request message' do
      Given(:binary) { [1, 5, 0, 8, 0, 0, 0, 0].pack('C*') }

      Then do
        result == Failure(Pio::ParseError, 'Invalid Echo message.')
      end
    end
  end
end
