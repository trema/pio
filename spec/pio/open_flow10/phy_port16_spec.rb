require 'pio'

describe Pio::OpenFlow10::PhyPort16 do
  describe '.new' do
    When(:phy_port) do
      Pio::OpenFlow10::PhyPort16.new(port_no: 1,
                                     hardware_address: '11:22:33:44:55:66',
                                     name: 'port123',
                                     config: [:port_down],
                                     state: [:link_down],
                                     curr: [:port_10gb_fd, :port_copper])
    end

    Then { phy_port.port_no == 1 }
    Then { phy_port.hardware_address == '11:22:33:44:55:66' }
    Then { phy_port.name == 'port123' }
    Then { phy_port.config == [:port_down] }
    Then { phy_port.state == [:link_down] }
    Then { phy_port.curr == [:port_10gb_fd, :port_copper] }
    Then { phy_port.advertised.empty? }
    Then { phy_port.supported.empty? }
    Then { phy_port.peer.empty? }
    Then { phy_port.to_binary_s.length > 0 }
  end
end
