require 'bindata'
require 'forwardable'
require 'pio/type/mac_address'

module Pio
  # An action to modify the source/destination Ethernet address of a packet.
  class SetEtherAddr
    # rubocop:disable MethodLength
    def self.def_format(action_type)
      str = %(
        class Format < BinData::Record
          endian :big

          uint16 :type, value: #{action_type}
          uint16 :message_length, value: 16
          mac_address :mac_address
          uint48 :padding
          hide :padding
        end
      )
      module_eval str
    end
    # rubocop:enable MethodLength

    def self.read(raw_data)
      set_ether_addr = allocate
      set_ether_addr.instance_variable_set(:@format,
                                           const_get(:Format).read(raw_data))
      set_ether_addr
    end

    extend Forwardable

    def_delegators :@format, :message_length
    def_delegators :@format, :mac_address
    def_delegator :@format, :to_binary_s, :to_binary

    def initialize(mac_address)
      @format = self.class.const_get(:Format).new(mac_address: mac_address)
    end
  end

  # An action to modify the source Ethernet address of a packet.
  class SetEtherSourceAddr < SetEtherAddr
    def_format 4
  end

  # An action to modify the destination Ethernet address of a packet.
  class SetEtherDestinationAddr < SetEtherAddr
    def_format 5
  end
end
