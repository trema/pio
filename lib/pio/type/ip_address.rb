# -*- coding: utf-8 -*-
require "bindata"
require "pio/ipv4_address"

module Pio
  module Type
    # IP address
    class IpAddress < BinData::Primitive
      array :octets, :type => :uint8, :initial_length => 4

      def set(value)
        self.octets = value
      end

      def get
        IPv4Address.new octets.map { | each | sprintf("%d", each) }.join( "." )
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
