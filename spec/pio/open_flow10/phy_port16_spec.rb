# frozen_string_literal: true

require 'pio'

describe Pio::OpenFlow10::PhyPort16 do
  describe '.new' do
    When(:phy_port) do
      Pio::OpenFlow10::PhyPort16.new(number: 1,
                                     mac_address: '11:22:33:44:55:66',
                                     name: 'port123',
                                     config: [:port_down],
                                     state: [:link_down],
                                     curr: %i[port_10gb_fd port_copper])
    end

    Then { phy_port.number == 1 }
    Then { phy_port.mac_address == '11:22:33:44:55:66' }
    Then { phy_port.name == 'port123' }
    Then { phy_port.config == [:port_down] }
    Then { phy_port.state == [:link_down] }
    Then { phy_port.curr == %i[port_10gb_fd port_copper] }
    Then { phy_port.advertised.empty? }
    Then { phy_port.supported.empty? }
    Then { phy_port.peer.empty? }
    Then { !phy_port.to_binary_s.empty? }
  end
end
