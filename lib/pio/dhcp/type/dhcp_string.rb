# encoding: utf-8

require 'bindata'

module Pio
  module Type
    # DHCP String Format.
    class DhcpString < BinData::Primitive
      string :dhcp_string,
             read_length: :tlv_info_length

      def set(value)
        self.dhcp_string = value
      end

      def get
        dhcp_string
      end
    end
  end
end
