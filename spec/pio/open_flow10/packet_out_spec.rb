# frozen_string_literal: true

require 'pio/open_flow10/packet_out'

describe Pio::OpenFlow10::PacketOut do
  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::OpenFlow10::PacketOut)
  end
end
