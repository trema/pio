# encoding: utf-8

require 'pio'

describe Pio::Features do
  describe '.read' do
    context 'with a Features Request message' do
      Given(:features_request_dump) { [1, 5, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:features_request) do
        Pio::Features.read(features_request_dump)
      end

      Then { features_request.class == Pio::Features::Request }
      Then { features_request.version == 1 }
      Then { features_request.message_type == Pio::Features::REQUEST }
      Then { features_request.message_length == 8 }
      Then { features_request.xid == 0 }
      Then { features_request.body.empty? }
    end

    context 'with a Hello message' do
      Given(:hello_dump) { [1, 0, 0, 8, 0, 0, 0, 0].pack('C*') }

      When(:result) { Pio::Features.read(hello_dump) }

      Then { result == Failure(Pio::ParseError) }
    end
  end
end
