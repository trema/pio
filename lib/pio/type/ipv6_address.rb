require 'bindata'
require 'ipaddr'

module Pio
  module Type
    # IPv6 address
    class Ipv6Address < BinData::Primitive
      endian :big

      uint128 :ipv6_address

      def set(value)
        self.ipv6_address = IPAddr.new(value, Socket::Constants::AF_INET6)
      end

      def get
        IPAddr.new(ipv6_address, Socket::Constants::AF_INET6).to_s
      end
    end
  end
end
