# encoding: utf-8

require 'bindata'

module Pio
  module Type
    module OpenFlow
      # Description of a physical port
      class PhyPort < BinData::Record
        endian :big

        uint16 :port_no
        uint8 :hw_addr
        stringz :name, read_length: 16
        uint32 :config
        uint32 :state
        uint32 :curr
        uint32 :advertised
        uint32 :supported
        uint32 :peer
      end
    end
  end
end
