require "forwardable"


module Pio
  #
  # Ethernet address (MAC address) class.
  #
  class Mac
    extend Forwardable
    def_delegator :@value, :hash


    #
    # Creates a {Mac} instance that encapsulates Ethernet addresses.
    #
    # @example address as a hexadecimal string
    #   Pio::Mac.new("11:22:33:44:55:66")
    # @example address as a hexadecimal number
    #   Pio::Mac.new(0xffffffffffff)
    #
    # @param value [#to_str, #to_int] the value converted to an
    #   Ethernet address.
    #
    def initialize value
      if value.respond_to?( :to_str )
        @value = parse_mac_string( value.to_str )
      elsif value.respond_to?( :to_int )
        @value = value.to_int
        validate_value_range
      else
        raise TypeError, "Invalid MAC address: #{ value.inspect }"
      end
    end


    # @!group Converters

    #
    # Returns an Ethernet address in its numeric presentation.
    #
    # @example
    #   Pio::Mac.new("11:22:33:44:55:66").to_i #=> 18838586676582
    #
    def to_i
      @value
    end


    #
    # @see to_i
    #
    def to_int
      to_i
    end


    #
    # Returns the Ethernet address as 6 pairs of hexadecimal digits
    # delimited by colons.
    #
    # @example
    #   Pio::Mac.new(18838586676582).to_s #=> "11:22:33:44:55:66"
    #
    def to_s
      sprintf( "%012x", @value ).unpack( "a2" * 6 ).join( ":" )
    end


    #
    # @see to_s
    #
    def to_str
      to_s
    end


    #
    # Returns an Array of decimal numbers converted from Ethernet's
    # address string format.
    #
    # @example
    #   Pio::Mac.new("11:22:33:44:55:66").to_a #=> [ 0x11, 0x22, 0x33, 0x44, 0x55, 0x66 ]
    #
    def to_a
      to_s.split( ":" ).collect do | each |
        each.hex
      end
    end


    #
    # @see to_a
    #
    def to_ary
      to_a
    end

    # @!endgroup


    # @!group Predicates

    #
    # Returns true if Ethernet address is a multicast address.
    #
    # @example
    #   Pio::Mac.new("01:00:00:00:00:00").multicast? #=> true
    #   Pio::Mac.new("00:00:00:00:00:00").multicast? #=> false
    #
    def multicast?
      to_a[ 0 ] & 1 == 1
    end


    #
    # Returns true if Ethernet address is a broadcast address.
    #
    # @example
    #   Pio::Mac.new("ff:ff:ff:ff:ff:ff").broadcast? #=> true
    #
    def broadcast?
      to_a.all? { | each | each == 0xff }
    end

    # @!endgroup


    # @!group Equality

    #
    # Returns true if other can be converted to a {Mac} object and its
    # numeric representation is equal to mine.
    #
    # @example
    #   Pio::Mac.new("11:22:33:44:55:66") == "11:22:33:44:55:66" #=> true
    #   Pio::Mac.new("11:22:33:44:55:66") == 18838586676582 #=> true
    #
    # @param other [#to_str, #to_int] a {Mac} object or an object that
    #   can be converted to an Ethernet address.
    #
    def == other
      begin
        to_i == Mac.new( other ).to_i
      rescue
        false
      end
    end
    alias :eql? :==

    # @!endgroup


    ################################################################################
    private
    ################################################################################


    def parse_mac_string mac
      octet_regex = "[0-9a-fA-F][0-9a-fA-F]"
      if /^(#{ octet_regex }:){5}(#{ octet_regex })$/=~ mac
        mac.gsub( ":", "" ).hex
      else
        raise ArgumentError, %{Invalid MAC address: "#{ mac }"}
      end
    end


    def validate_value_range
      unless ( @value >= 0 and @value <= 0xffffffffffff )
        raise ArgumentError, "Invalid MAC address: #{ @value }"
      end
    end
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
