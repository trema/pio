require 'pio/open_flow13/packet_in'

describe Pio::PacketIn do
  Given(:packet_in) { Pio::PacketIn.new }

  describe 'datapath_id=' do
    When { packet_in.datapath_id = 1 }
    Then { packet_in.datapath_id == 1 }
  end
end
