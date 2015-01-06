require 'bindata'
require 'forwardable'

module Pio
  # An action to modify the VLAN related fields of a packet.
  class SetVlan
    extend Forwardable

    # rubocop:disable MethodLength
    def self.def_format(field_name, action_type)
      str = %(
        class Format < BinData::Record
          endian :big

          uint16 :type, value: #{action_type}
          uint16 :message_length, value: 8
          uint16 :#{field_name}
          uint16 :padding
          hide :padding
        end
      )
      module_eval str
      module_eval "def_delegators :@format, :#{field_name}"
    end
    # rubocop:enable MethodLength

    def self.read(raw_data)
      set_vlan = allocate
      set_vlan.instance_variable_set :@format, const_get(:Format).read(raw_data)
      set_vlan
    end

    def_delegators :@format, :type
    def_delegators :@format, :message_length
    def_delegator :@format, :to_binary_s, :to_binary
  end
end
