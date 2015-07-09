require 'pio/open_flow13/packet_out'

describe Pio::OpenFlow13::PacketOut do
  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::OpenFlow13::PacketOut)
  end
end
