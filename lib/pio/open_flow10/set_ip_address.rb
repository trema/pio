require 'bindata'
require 'forwardable'
require 'pio/type/ip_address'

module Pio
  # An action to modify the IPv4 source/destination address of a packet.
  class SetIpAddress
    def self.def_format(action_type)
      str = %(
        class Format < BinData::Record
          endian :big

          uint16 :action_type, value: #{action_type}
          uint16 :action_length, value: 8
          ip_address :ip_address
        end
      )
      module_eval str
    end

    def self.read(raw_data)
      set_ip_address = allocate
      set_ip_address.instance_variable_set(:@format,
                                           const_get(:Format).read(raw_data))
      set_ip_address
    end

    extend Forwardable

    def_delegators :@format, :action_type
    def_delegator :@format, :action_length, :length
    def_delegators :@format, :ip_address
    def_delegator :@format, :to_binary_s, :to_binary

    def initialize(ip_address)
      @format = self.class.const_get(:Format).new(ip_address: ip_address)
    end
  end

  # An action to modify the IPv4 source address of a packet.
  class SetIpSourceAddress < SetIpAddress
    def_format 6
  end

  # An action to modify the IPv4 source address of a packet.
  class SetIpDestinationAddress < SetIpAddress
    def_format 7
  end
end
