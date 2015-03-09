require 'forwardable'

module Pio
  #
  # Ethernet address (MAC address) class.
  #
  class Mac
    # Raised when Ethernet address is invalid.
    class InvalidValueError < StandardError; end

    extend Forwardable
    def_delegator :@value, :hash

    #
    # Creates a {Mac} instance that encapsulates Ethernet addresses.
    #
    # @example address as a hexadecimal string
    #   Mac.new("11:22:33:44:55:66")
    # @example address as a hexadecimal number
    #   Mac.new(0xffffffffffff)
    #
    # @param value [#to_str, #to_int] the value converted to an
    #   Ethernet address.
    #
    def initialize(value)
      if value.respond_to?(:to_str)
        @value = parse_mac_string(value.to_str)
      elsif value.respond_to?(:to_int)
        @value = value.to_int
        validate_value_range
      else
        fail TypeError
      end
    rescue ArgumentError, TypeError
      raise InvalidValueError, "Invalid MAC address: #{value.inspect}"
    end

    # @!group Converters

    #
    # Returns an Ethernet address in its numeric presentation.
    #
    # @example
    #   Mac.new("11:22:33:44:55:66").to_i #=> 18838586676582
    #
    # @return [Integer]
    #
    def to_i
      @value
    end

    #
    # Returns the Ethernet address as 6 pairs of hexadecimal digits
    # delimited by colons.
    #
    # @example
    #   Mac.new(0x112233445566).to_s #=> "11:22:33:44:55:66"
    #
    # @return [String]
    #
    def to_s
      format('%012x', @value).unpack('a2' * 6).join(':')
    end

    #
    # Implicitly converts +obj+ to a string.
    #
    # @example
    #   mac = Mac.new("11:22:33:44:55:66")
    #   puts "MAC = " + mac #=> "MAC = 11:22:33:44:55:66"
    #
    # @see #to_s
    #
    # @return [String]
    #
    def to_str
      to_s
    end

    #
    # Returns an Array of decimal numbers converted from Ethernet's
    # address string format.
    #
    # @example
    #   Mac.new("11:22:33:44:55:66").to_a
    #   #=> [0x11, 0x22, 0x33, 0x44, 0x55, 0x66]
    #
    # @return [Array]
    #
    def to_a
      to_s.split(':').map(&:hex)
    end

    # @!endgroup

    # @!group Predicates

    #
    # Returns true if Ethernet address is a multicast address.
    #
    # @example
    #   Mac.new("01:00:00:00:00:00").multicast? #=> true
    #   Mac.new("00:00:00:00:00:00").multicast? #=> false
    #
    def multicast?
      to_a[0] & 1 == 1
    end

    #
    # Returns true if Ethernet address is a broadcast address.
    #
    # @example
    #   Mac.new("ff:ff:ff:ff:ff:ff").broadcast? #=> true
    #
    def broadcast?
      to_a.all? { |each| each == 0xff }
    end

    #
    # Returns +true+ if Ethernet address is an IEEE 802.1D or 802.1Q
    # reserved address. See
    # http://standards.ieee.org/develop/regauth/grpmac/public.html for
    # details.
    #
    # @example
    #   Mac.new("01:80:c2:00:00:00").reserved? #=> true
    #   Mac.new("11:22:33:44:55:66").reserved? #=> false
    #
    def reserved?
      (to_i >> 8) == 0x0180c20000
    end

    # @!endgroup

    # @!group Equality

    #
    # Returns +true+ if +other+ can be converted to a {Mac}
    # object and its string representation is equal to +obj+'s.
    #
    # @example
    #   mac_address = Mac.new("11:22:33:44:55:66")
    #
    #   mac_address == Mac.new("11:22:33:44:55:66") #=> true
    #   mac_address == "11:22:33:44:55:66" #=> true
    #   mac_address == "INVALID_MAC_ADDRESS" #=> false
    #
    # @param other [#to_s] a {Mac} object or an object that can be
    #   converted to an Ethernet address.
    #
    # @return [Boolean]
    #
    def ==(other)
      return false if other.is_a?(Integer)
      to_s == Mac.new(other).to_s
    rescue InvalidValueError
      false
    end

    #
    # Returns +true+ if +obj+ and +other+ refer to the same hash key.
    # +#==+ is used for the comparison.
    #
    # @example
    #   fdb = {
    #     Mac.new("11:22:33:44:55:66") => 1,
    #     Mac.new("66:55:44:33:22:11") => 2
    #   }
    #
    #   fdb[ Mac.new("11:22:33:44:55:66")] #=> 1
    #   fdb["11:22:33:44:55:66"] #=> 1
    #   fdb[0x112233445566] #=> 1
    #
    # @see #==
    #
    def eql?(other)
      self == other
    end

    # @!endgroup

    # @!group Debug

    #
    # Returns a string containing a human-readable representation of
    # {Mac} for debugging.
    #
    # @return [String]
    #
    def inspect
      %(#<#{self.class}:#{__id__} "#{self}">)
    end

    # @!endgroup

    private

    def parse_mac_string(mac)
      octet = '[0-9a-fA-F][0-9a-fA-F]'
      doctet = octet * 2
      case mac
      when /^(?:#{octet}(:)){5}#{octet}$/, /^(?:#{doctet}(\.)){2}#{doctet}$/
        mac.gsub(Regexp.last_match[1], '').hex
      else
        fail ArgumentError
      end
    end

    def validate_value_range
      fail ArgumentError unless @value >= 0 && @value <= 0xffffffffffff
    end
  end
end
