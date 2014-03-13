# -*- coding: utf-8 -*-

require 'pio/mac'

module Pio
  class Dhcp
    # Dhcp Consts
    module Consts
      # Dhcp Type of Optional TLV Constants.
      MESSAGE_TYPE_TLV = 53
      SERVER_IDENTIFIER_TLV = 54
      CLIENT_IDENTIFIER_TLV = 61
      RENEWAL_TIME_VALUE_TLV = 58
      REBINDING_TIME_VALUE_TLV = 59
      HOST_NAME_TLV = 12
      CLIENT_FQDN_TLV = 81
      REQUESTED_IP_ADDRESS_TLV = 50
      VENDOR_CLASS_IDENTIFIER_TLV = 60
      PARAMETERS_LIST_TLV = 55
      IP_ADDRESS_LEASE_TIME_TLV = 51
      SUBNET_MASK_TLV = 1
      BOOT_FILE_NAME_TLV = 67
      ROUTER_TLV = 3
      TFTP_SERVER_NAME_TLV = 66
      TIME_OFFSET_TLV = 2
      TIME_SERVER_TLV = 4
      NTP_SERVERS_TLV = 42
      DNS_TLV = 6
      LOG_SERVER_TLV = 7
      DOCSYS_FULL_SECURITY_SERVER_IP_TLV = 128
      END_OF_TLV = 255
      DEFAULT = 'default'

      # Dhcp Field Constants
      MAGICCOOKIE = 'c\202Sc'
      MAGICCOOKIELENGTH = 4
      ETHERNET = 1
      MACADDRESSLENGTH = 6

      # Dhcp Frame Constants.
      ETHER_TYPE_IP = 0x0800
      IP_PROTOCOL_UDP = 17
      IP_HEADER_LENGTH = 20
      DHCP_PACKET_LENGTH = 328
      DHCP_UDP_LENGTH = 308
      UDP_HEADER_LENGTH = 8
      DHCP_MANDATORY_FIELD_LENGTH = 236
      DHCP_OPTION_FIELD_LENGTH = 60

      # Dhcp Base Constants
      BOOTPC = 68
      BOOTPS = 67
      QUAD_ZERO_IP_ADDRESS = IPv4Address.new(0).to_a
      BROADCAST_MAC_ADDRESS = Mac.new(0xffffffffffff).to_a
      BROADCAST_IP_ADDRESS = IPv4Address.new(0xffffffff).to_a
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
