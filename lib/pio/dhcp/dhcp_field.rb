require 'pio/dhcp/optional_tlv'
require 'pio/type/ip_address'
require 'pio/type/mac_address'

module Pio
  class Dhcp
    # DHCP Field
    class DhcpField < BinData::Record
      MAGIC_COOKIE = 0x63825363
      ETHERNET = 1
      MAC_ADDRESS_LENGTH = 6

      endian :big

      uint8 :message_type
      uint8 :hw_addr_type,
            initial_value: ETHERNET
      uint8 :hw_addr_len,
            initial_value: MAC_ADDRESS_LENGTH
      uint8 :hops,
            initial_value: 0
      uint32be :transaction_id,
               initial_value: rand(0xffffffff)
      uint16be :seconds,
               initial_value: 0
      uint16be :bootp_flags,
               initial_value: 0
      ip_address :client_ip_address
      ip_address :your_ip_address
      ip_address :next_server_ip_address
      ip_address :relay_agent_ip_address
      mac_address :client_mac_address
      string :client_mac_address_padding,
             length: 10
      string :server_host_name,
             length: 64
      string :boot_file_name,
             length: 128
      uint32be :magic_cookie,
               value: MAGIC_COOKIE
      array :optional_tlvs,
            type: :optional_tlv,
            read_until: -> { element.end_of_dhcptlv? }
    end
  end
end
