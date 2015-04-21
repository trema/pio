require 'bindata'
require 'forwardable'
require 'pio/monkey_patch/integer'

module Pio
  # An action to modify the IP ToS/DSCP field of a packet.
  class SetIpTos
    # OpenFlow 1.0 OFPAT_SET_NW_TOS action format.
    class Format < BinData::Record
      endian :big

      uint16 :type, value: 8
      uint16 :message_length, value: 8
      uint8 :type_of_service
      uint24 :padding
      hide :padding
    end

    def self.read(raw_data)
      set_ip_tos = allocate
      set_ip_tos.instance_variable_set :@format, Format.read(raw_data)
      set_ip_tos
    end

    extend Forwardable

    def_delegators :@format, :type
    def_delegators :@format, :message_length
    def_delegators :@format, :type_of_service
    def_delegator :@format, :to_binary_s, :to_binary

    def initialize(type_of_service)
      # ip_tos (IP ToS) value consists of 8 bits, of which only the 6
      # high-order bits belong to DSCP, the 2 low-order bits must be
      # zero.
      unless type_of_service.unsigned_8bit? && type_of_service % 4 == 0
        fail ArgumentError, 'Invalid type_of_service (ToS) value.'
      end
      @format = Format.new(type_of_service: type_of_service)
    end
  end
end
