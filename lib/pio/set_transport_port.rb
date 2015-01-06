require 'bindata'
require 'forwardable'
require 'pio/monkey_patch/integer'

module Pio
  # An action to modify the source/destination TCP/UDP port of a packet.
  class SetTransportPort
    # rubocop:disable MethodLength
    def self.def_format(action_type)
      str = %(
        class Format < BinData::Record
          endian :big

          uint16 :type, value: #{action_type}
          uint16 :message_length, value: 8
          uint16 :port_number
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

    def_delegators :@format, :type
    def_delegators :@format, :message_length
    def_delegators :@format, :port_number
    def_delegator :@format, :to_binary_s, :to_binary

    def initialize(number)
      port_number = number.to_i
      unless port_number.unsigned_16bit?
        fail ArgumentError, 'TCP/UDP port must be an unsigned 16-bit integer.'
      end
      @format = self.class.const_get(:Format).new(port_number: port_number)
    rescue NoMethodError
      raise TypeError, 'TCP/UDP port must be an unsigned 16-bit integer.'
    end
  end

  # An action to modify the source TCP/UDP port of a packet.
  class SetTransportSrcPort < SetTransportPort
    def_format 9
  end

  # An action to modify the source TCP/UDP port of a packet.
  class SetTransportDstPort < SetTransportPort
    def_format 10
  end
end
