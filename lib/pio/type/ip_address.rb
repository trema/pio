require 'bindata'
require 'pio/ipv4_address'

module Pio
  module Type
    # IP address
    class IpAddress < BinData::Primitive
      array :octets, type: :uint8, initial_length: 4

      def set(value)
        case value
        when String
          self.octets = value.split('.').map(&:to_i)
        else
          self.octets = value
        end
      end

      def get
        IPv4Address.new octets.map { |each| format('%d', each) }.join('.')
      end

      def ==(other)
        get == other
      end
    end
  end
end
