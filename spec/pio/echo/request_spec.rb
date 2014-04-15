# encoding: utf-8

require 'pio'

describe Pio::Echo::Request do
  describe '.new' do
    Given(:echo_request) do
      Pio::Echo::Request.new(user_options)
    end

    context 'with no arguments' do
      When(:user_options) { {} }

      Then { echo_request.class == Pio::Echo::Request }
      Then { echo_request.version == 1 }
      Then { echo_request.message_type == Pio::Echo::REQUEST }
      Then { echo_request.message_length == 8 }
      Then { echo_request.transaction_id == 0 }
      Then { echo_request.xid == 0 }
      Then { echo_request.data == '' }
    end

    context 'with transaction_id: 123' do
      When(:user_options) { { transaction_id: 123 } }

      Then { echo_request.class == Pio::Echo::Request }
      Then { echo_request.version == 1 }
      Then { echo_request.message_type == Pio::Echo::REQUEST }
      Then { echo_request.message_length == 8 }
      Then { echo_request.transaction_id == 123 }
      Then { echo_request.xid == 123 }
      Then { echo_request.data == '' }
    end

    context 'with xid: 123' do
      When(:user_options) { { xid: 123 } }

      Then { echo_request.class == Pio::Echo::Request }
      Then { echo_request.version == 1 }
      Then { echo_request.message_type == Pio::Echo::REQUEST }
      Then { echo_request.message_length == 8 }
      Then { echo_request.transaction_id == 123 }
      Then { echo_request.xid == 123 }
      Then { echo_request.data == '' }
    end
  end
end
