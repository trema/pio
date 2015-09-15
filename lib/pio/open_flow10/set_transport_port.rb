require 'bindata'
require 'forwardable'
require 'pio/monkey_patch/integer'

module Pio
  # An action to modify the source/destination TCP/UDP port of a packet.
  class SetTransportPort
    # rubocop:disable MethodLength
    def self.action_type(action_type)
      str = %(
        class Format < BinData::Record
          endian :big

          uint16 :action_type, value: #{action_type}
          uint16 :action_length, value: 8
          uint16 :port
          uint16 :padding
          hide :padding
        end
      )
      module_eval str
    end
    # rubocop:enable MethodLength

    def self.read(raw_data)
      action = allocate
      action.instance_variable_set(:@format, const_get(:Format).read(raw_data))
      action
    end

    extend Forwardable

    def_delegators :@format, :action_type
    def_delegator :@format, :action_length, :length
    def_delegators :@format, :port
    def_delegator :@format, :to_binary_s, :to_binary

    def initialize(number)
      port = number.to_i
      unless port.unsigned_16bit?
        fail ArgumentError, 'TCP/UDP port must be an unsigned 16-bit integer.'
      end
      @format = self.class.const_get(:Format).new(port: port)
    rescue NoMethodError
      raise TypeError, 'TCP/UDP port must be an unsigned 16-bit integer.'
    end
  end

  # An action to modify the source TCP/UDP port of a packet.
  class SetTransportSourcePort < SetTransportPort
    action_type 9
  end

  # An action to modify the source TCP/UDP port of a packet.
  class SetTransportDestinationPort < SetTransportPort
    action_type 10
  end
end
