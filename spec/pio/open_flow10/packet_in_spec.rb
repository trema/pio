require 'pio/open_flow10/packet_in'

describe Pio::PacketIn do
  Given(:packet_in) { Pio::PacketIn.new }

  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::PacketIn)
  end

  describe 'datapath_id=' do
    When { packet_in.datapath_id = 1 }
    Then { packet_in.datapath_id == 1 }
  end
end
