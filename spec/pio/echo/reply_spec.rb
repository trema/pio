# encoding: utf-8

require 'pio'

describe Pio::Echo::Reply do
  describe '.new' do
    context 'with no additional data' do
      When(:echo_reply) do
        Pio::Echo::Reply.new
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
