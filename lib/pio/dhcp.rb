# Packet parser and generator library.
module Pio
  # Dhcp parser and generator.
  class Dhcp
    MESSAGE_TYPE_TLV = 53
    SERVER_IDENTIFIER_TLV = 54
    CLIENT_IDENTIFIER_TLV = 61
    RENEWAL_TIME_VALUE_TLV = 58
    REBINDING_TIME_VALUE_TLV = 59
    REQUESTED_IP_ADDRESS_TLV = 50
    PARAMETERS_LIST_TLV = 55
    IP_ADDRESS_LEASE_TIME_TLV = 51
    SUBNET_MASK_TLV = 1
    ROUTER_TLV = 3
    NTP_SERVERS_TLV = 42
    DNS_TLV = 6
    END_OF_TLV = 255

    PARAMETER_REQUEST_LIST =
      [
        SUBNET_MASK_TLV,
        ROUTER_TLV,
        DNS_TLV,
        NTP_SERVERS_TLV
      ]
  end
  DHCP = Dhcp
end

require 'bindata'
require 'pio/dhcp/discover'
require 'pio/dhcp/offer'
require 'pio/dhcp/request'
require 'pio/dhcp/ack'

module Pio
  # Dhcp parser and generator.
  class Dhcp
    MESSAGE_TYPE = {
      Discover::TYPE => Discover,
      Offer::TYPE => Offer,
      Request::TYPE => Request,
      Ack::TYPE => Ack
    }

    def self.read(raw_data)
      begin
        frame = const_get('Frame').read(raw_data)
      rescue
        raise Pio::ParseError, $ERROR_INFO.message
      end

      const_get('MESSAGE_TYPE')[frame.message_type].create_from(frame)
    end
  end
end
