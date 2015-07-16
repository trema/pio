require 'pio/open_flow13/packet_in'

describe Pio::OpenFlow13::PacketIn do
  Given(:packet_in) { Pio::OpenFlow13::PacketIn.new }

  describe '.new' do
    it_should_behave_like('an OpenFlow message', Pio::OpenFlow13::PacketIn)
  end

  describe 'datapath_id=' do
    When { packet_in.datapath_id = 1 }
    Then { packet_in.datapath_id == 1 }
  end
end
