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
      Then { echo_request.message_length == 8 }
      Then { echo_request.xid == 0 }
      Then { echo_request.data == '' }
    end
  end
end
