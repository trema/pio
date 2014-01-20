# -*- coding: utf-8 -*-
require 'bindata'

module Pio
  module Type
    # DHCP ParameterList Format.
    class ParameterList < BinData::Primitive
      array :octets,
            :type => :uint8,
            :initial_length => :tlv_info_length

      def set(value)
        self.octets = value
      end

      def get
        octets
      end
    end
  end
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
