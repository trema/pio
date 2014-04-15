# encoding: utf-8

require 'pio'

describe Pio::Echo::Request do
  describe '.new' do
    context 'with no additional data' do
      When(:echo_request) do
        Pio::Echo::Request.new
      end

      Then { echo_request.class == Pio::Echo::Request }
      Then { echo_request.version == 1 }
      Then { echo_request.message_type == Pio::Echo::REQUEST }
      Then { echo_request.message_length == 8 }
      Then { echo_request.xid == 0 }
      Then { echo_request.data == '' }
    end
  end
end
