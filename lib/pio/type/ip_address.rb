require 'bindata'
require 'pio/ipv4_address'

module Pio
  module Type
    # IP address
    class IpAddress < BinData::Primitive
      array :octets, type: :uint8, initial_length: 4

      def set(value)
        self.octets = IPv4Address.new(value).to_a
      end

      def get
        IPv4Address.new(octets.map { |each| format('%d', each) }.join('.'))
      end

      def >>(other)
        get.to_i >> other
      end

      def &(other)
        get.to_i & other
      end

      def ==(other)
        get == other
      end
    end
  end
end
