require 'bindata'
require 'forwardable'
require 'pio/type/mac_address'

module Pio
  # An action to modify the source/destination Ethernet address of a packet.
  class SetEtherAddress
    # rubocop:disable MethodLength
    def self.action_type(action_type)
      str = %(
        class Format < BinData::Record
          endian :big

          uint16 :action_type, value: #{action_type}
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
      set_ether_address = allocate
      set_ether_address.instance_variable_set(:@format,
                                              const_get(:Format).read(raw_data))
      set_ether_address
    end

    extend Forwardable

    def_delegators :@format, :action_type
    def_delegators :@format, :message_length
    def_delegators :@format, :mac_address
    def_delegator :@format, :to_binary_s, :to_binary

    def initialize(mac_address)
      @format = self.class.const_get(:Format).new(mac_address: mac_address)
    end
  end

  # An action to modify the source Ethernet address of a packet.
  class SetEtherSourceAddress < SetEtherAddress
    action_type 4
  end

  # An action to modify the destination Ethernet address of a packet.
  class SetEtherDestinationAddr < SetEtherAddress
    action_type 5
  end
end
