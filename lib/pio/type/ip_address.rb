require 'bindata'
require 'pio/ipv4_address'

module Pio
  module Type
    # IP address
    class IpAddress < BinData::Primitive
      array :octets, type: :uint8, initial_length: 4

      def set(value)
        address = IPv4Address.new(value)
        @match_nw = 32 - address.prefixlen
        self.octets = address.to_a
      end

      def get
        IPv4Address.new octets.map { |each| format('%d', each) }.join('.')
      end

      attr_reader :match_nw

      def ==(other)
        get == other
      end
    end
  end
end
