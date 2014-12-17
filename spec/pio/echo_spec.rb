require 'pio/echo'

describe Pio::Echo do
  describe '.read' do
    context 'with an Echo Request message' do
      Given(:echo_request_dump) do
        [1, 2, 0, 8, 0, 0, 0, 0].pack('C*')
      end

      When(:echo_request) do
        Pio::Echo.read echo_request_dump
      end

      Then { echo_request.class == Pio::Echo::Request }
      Then { echo_request.ofp_version == 1 }
      Then { echo_request.message_type == Pio::OpenFlow::Type::ECHO_REQUEST }
      Then { echo_request.message_length == 8 }
      Then { echo_request.xid == 0 }
      Then { echo_request.user_data == '' }
      Then { echo_request.to_binary == echo_request_dump }
    end

    context 'with an Echo Reply message' do
      Given(:echo_reply_dump) do
        [1, 3, 0, 8, 0, 0, 0, 0].pack('C*')
      end

      When(:echo_reply) do
        Pio::Echo.read echo_reply_dump
      end

      Then { echo_reply.class == Pio::Echo::Reply }
      Then { echo_reply.ofp_version == 1 }
      Then { echo_reply.message_type == Pio::OpenFlow::Type::ECHO_REPLY }
      Then { echo_reply.message_length == 8 }
      Then { echo_reply.xid == 0 }
      Then { echo_reply.user_data == '' }
      Then { echo_reply.to_binary == echo_reply_dump }
    end

    context 'with a Features Request message' do
      Given(:features_request_dump) { [1, 5, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:result) { Pio::Echo.read(features_request_dump) }

      Then { result == Failure(Pio::ParseError) }
    end
  end
end
