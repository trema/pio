require 'pio'

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
      Then { echo_request.version == 1 }
      Then { echo_request.message_type == Pio::Echo::REQUEST }
      Then { echo_request.message_length == 8 }
      Then { echo_request.xid == 0 }
      Then { echo_request.data == '' }
    end

    context 'with an Echo Reply message' do
      Given(:echo_reply_dump) do
        [1, 3, 0, 8, 0, 0, 0, 0].pack('C*')
      end

      When(:echo_reply) do
        Pio::Echo.read echo_reply_dump
      end

      Then { echo_reply.class == Pio::Echo::Reply }
      Then { echo_reply.version == 1 }
      Then { echo_reply.message_type == Pio::Echo::REPLY }
      Then { echo_reply.message_length == 8 }
      Then { echo_reply.xid == 0 }
      Then { echo_reply.data == '' }
    end
  end
end
