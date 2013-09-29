require "forwardable"
require "pio/lldp/frame"


module Pio
  # LLDP frame parser and generator.
  class Lldp
    # User options for creating an LLDP frame.
    class Options
      def initialize options
        @options = options

        unless dpid
          raise TypeError, "Invalid DPID: #{ dpid.inspect }"
        end
        unless port_id
          raise TypeError, "Invalid port number: #{ port_id.inspect }"
        end
      end


      def to_hash
        {
          :destination_mac => Mac.new( destination_mac ).to_a,
          :source_mac => Mac.new( source_mac ).to_a,
          :chassis_id => dpid,
          :port_id => port_id
        }
      end


      ##########################################################################
      private
      ##########################################################################


      def dpid
        @options[ :dpid ]
      end


      def port_id
        @options[ :port_number ]
      end


      def destination_mac
        @options[ :destination_mac ] || "01:80:c2:00:00:0e"
      end


      def source_mac
        @options[ :source_mac ] || "01:02:03:04:05:06"
      end
    end


    extend Forwardable


    def self.read raw_data
      begin
        frame = Frame.read( raw_data )
      rescue
        raise Pio::ParseError, $!.message
      end

      lldp = allocate
      lldp.instance_variable_set :@frame, frame
      lldp
    end


    def initialize options
      @frame = Frame.new( Options.new( options ).to_hash )
    end


    def_delegator :@frame, :destination_mac
    def_delegator :@frame, :source_mac
    def_delegator :@frame, :ether_type
    def_delegator :@frame, :chassis_id
    def_delegator :@frame, :dpid
    def_delegator :@frame, :optional_tlv
    def_delegator :@frame, :port_id
    alias :port_number :port_id
    def_delegator :@frame, :ttl
    def_delegator :@frame, :port_description
    def_delegator :@frame, :system_name
    def_delegator :@frame, :system_description
    def_delegator :@frame, :system_capabilities
    def_delegator :@frame, :enabled_capabilities
    def_delegator :@frame, :management_address
    def_delegator :@frame, :organizationally_specific


    def to_binary
      @frame.to_binary_s + "\000" * ( 64 - @frame.num_bytes )
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
