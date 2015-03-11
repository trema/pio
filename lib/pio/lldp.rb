require 'English'
require 'forwardable'
require 'pio/lldp/frame'
require 'pio/lldp/options'

# Packet parser and generator library.
module Pio
  # LLDP frame parser and generator.
  class Lldp
    extend Forwardable

    def_delegator :@frame, :destination_mac
    def_delegator :@frame, :source_mac
    def_delegator :@frame, :ether_type
    def_delegator :@frame, :chassis_id
    def_delegator :@frame, :dpid
    def_delegator :@frame, :optional_tlv
    def_delegator :@frame, :port_id
    def_delegator :@frame, :ttl
    def_delegator :@frame, :port_description
    def_delegator :@frame, :system_name
    def_delegator :@frame, :system_description
    def_delegator :@frame, :system_capabilities
    def_delegator :@frame, :enabled_capabilities
    def_delegator :@frame, :management_address
    def_delegator :@frame, :organizationally_specific

    def self.read(raw_data)
      begin
        frame = Frame.read(raw_data)
      rescue
        raise Pio::ParseError, $ERROR_INFO.message
      end

      lldp = allocate
      lldp.instance_variable_set :@frame, frame
      lldp
    end

    def initialize(options)
      @frame = Frame.new(Options.new(options).to_hash)
    end

    def port_number
      @frame.port_id.get.snapshot
    end

    def to_binary
      @frame.to_binary_s + "\000" * (64 - @frame.num_bytes)
    end
  end
  LLDP = Lldp
end
