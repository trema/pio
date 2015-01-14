require 'bindata'
require 'pio/ipv4_address'

module Pio
  module Type
    # IP address
    class IpAddress < BinData::Primitive
      array :octets, type: :uint8, initial_length: 4

      def set(value)
        @address = IPv4Address.new(value)
        self.octets = @address.to_a
      end

      def get
        @address ||
          IPv4Address.new(octets.map { |each| format('%d', each) }.join('.'))
      end

      def match_nw
        32 - @address.prefixlen if @address
      end

      def ==(other)
        get == other
      end
    end
  end
end
