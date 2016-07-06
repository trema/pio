Feature: EthernetHeader
  Scenario: create an Ethernet header
    When I create a packet with:
      """ruby
      Pio::EthernetHeader.new(
        destination_mac: 'ff:ff:ff:ff:ff:ff',
        source_mac: '00:26:82:eb:ea:d1',
        ether_type: Pio::Ethernet::Type::IPV4
      )
      """
    Then the packet has the following fields and values:
      | field             | value               |
      | class             | Pio::EthernetHeader |
      | destination_mac   | ff:ff:ff:ff:ff:ff   |
      | source_mac        | 00:26:82:eb:ea:d1   |
      | ether_type.to_hex | 0x08, 0x00          |

  Scenario: create a VLAN-tagged Ethernet header
    When I create a packet with:
      """ruby
      Pio::EthernetHeader.new(
        destination_mac: 'ff:ff:ff:ff:ff:ff',
        source_mac: '00:26:82:eb:ea:d1',
        ether_type: Pio::Ethernet::Type::VLAN,
        vlan_pcp: 5,
        vlan_cfi: 0,
        vlan_vid: 100
      )
      """
    Then the packet has the following fields and values:
      | field             | value               |
      | class             | Pio::EthernetHeader |
      | destination_mac   | ff:ff:ff:ff:ff:ff   |
      | source_mac        | 00:26:82:eb:ea:d1   |
      | ether_type.to_hex | 0x81, 0x00          |
      | vlan_pcp          | 5                   |
      | vlan_cfi          | 0                   |
      | vlan_vid          | 100                 |

  Scenario: read an Ethernet header
    Given I use the fixture "ethernet_header"
    When I create a packet with:
      """ruby
      Pio::EthernetHeader.read(eval(IO.read('ethernet_header.rb')))
      """
    Then the packet has the following fields and values:
      | field             | value               |
      | class             | Pio::EthernetHeader |
      | destination_mac   | ff:ff:ff:ff:ff:ff   |
      | source_mac        | 00:26:82:eb:ea:d1   |
      | ether_type.to_hex | 0x08, 0x00          |

  Scenario: read a VLAN-tagged Ethernet header
    Given I use the fixture "ethernet_header"
    When I create a packet with:
      """ruby
      Pio::EthernetHeader.read(eval(IO.read('vlan_ethernet_header.rb')))
      """
    Then the packet has the following fields and values:
      | field             | value               |
      | class             | Pio::EthernetHeader |
      | destination_mac   | ff:ff:ff:ff:ff:ff   |
      | source_mac        | 00:26:82:eb:ea:d1   |
      | ether_type.to_hex | 0x81, 0x00          |
      | vlan_pcp          | 5                   |
      | vlan_cfi          | 0                   |
      | vlan_vid          | 100                 |

  Scenario: convert Ethernet header to Ruby code
    When I eval the following Ruby code:
      """ruby
      Pio::EthernetHeader.new(
        destination_mac: 'ff:ff:ff:ff:ff:ff',
        source_mac: '00:26:82:eb:ea:d1',
        ether_type: Pio::Ethernet::Type::IPV4
      ).to_ruby
      """
    Then the result of eval should be:
      """ruby
      [
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, # destination_mac
        0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # source_mac
        0x08, 0x00, # ether_type
      ].pack('C14')
      """

  Scenario: convert VLAN-tagged Ethernet header to Ruby code
    When I eval the following Ruby code:
      """ruby
      Pio::EthernetHeader.new(
        destination_mac: 'ff:ff:ff:ff:ff:ff',
        source_mac: '00:26:82:eb:ea:d1',
        ether_type: Pio::Ethernet::Type::VLAN,
        vlan_pcp: 5,
        vlan_cfi: 0,
        vlan_vid: 100
      ).to_ruby
      """
    Then the result of eval should be:
      """ruby
      [
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, # destination_mac
        0x00, 0x26, 0x82, 0xeb, 0xea, 0xd1, # source_mac
        0x81, 0x00, # ether_type
        0b101_0_000001100100, # vlan_pcp, vlan_cfi, vlan_vid
        0x81, 0x00, # ether_type_vlan
      ].pack('C14nC2')
      """

  Scenario: EthernetHeader instance inspection
    When I eval the following Ruby code:
      """ruby
      Pio::EthernetHeader.new(
        destination_mac: 'ff:ff:ff:ff:ff:ff',
        source_mac: '00:26:82:eb:ea:d1',
        ether_type: Pio::Ethernet::Type::IPV4,
      ).inspect
      """
    Then the result of eval should be:
      """
      #<EthernetHeader destination_mac: "ff:ff:ff:ff:ff:ff", source_mac: "00:26:82:eb:ea:d1", ether_type: 0x0800>
      """

  Scenario: VLAN-tagged EthernetHeader instance inspection
    When I eval the following Ruby code:
      """ruby
      Pio::EthernetHeader.new(
        destination_mac: 'ff:ff:ff:ff:ff:ff',
        source_mac: '00:26:82:eb:ea:d1',
        ether_type: Pio::Ethernet::Type::VLAN,
        vlan_pcp: 5,
        vlan_cfi: 0,
        vlan_vid: 100
      ).inspect
      """
    Then the result of eval should be:
      """
      #<EthernetHeader destination_mac: "ff:ff:ff:ff:ff:ff", source_mac: "00:26:82:eb:ea:d1", ether_type: 0x8100, vlan_pcp: 5, vlan_cfi: 0, vlan_vid: 100>
      """

  Scenario: EthernetHeader class inspection
    When I eval the following Ruby code:
      """ruby
      Pio::EthernetHeader.inspect
      """
    Then the result of eval should be:
      """
      EthernetHeader(destination_mac: mac_address, source_mac: mac_address, ether_type: uint16, vlan_pcp: bit3, vlan_cfi: bit1, vlan_vid: bit12)
      """
