module Pio
  #
  # A wrapper class to IPAddr
  #
  class IP
    require "ipaddr"


    #
    # @return [IPAddr] value object instance of proxied IPAddr.
    #
    attr_reader :value


    attr_reader :prefixlen


    #
    # Creates a {IP} instance object as a proxy to IPAddr class.
    #
    # @overload initialize(addr)
    #
    # @param [String, Number] addr
    #   an IPv4 address specified either as a String or Number.
    #
    # @param [Number] prefixlen
    #   masking IPv4 address with given prefixlen.
    #
    # @raise [ArgumentError] invalid address if supplied argument is invalid
    #   IPv4 address.
    #
    # @return [IP] self
    #   a proxy to IPAddr.
    #
    def initialize addr, prefixlen = 32
      @prefixlen = prefixlen
      case addr
      when Integer
        @value = IPAddr.new( addr, Socket::AF_INET )
      when String
        @value = IPAddr.new( addr )
      else
        raise TypeError, "Invalid IP address: #{ addr.inspect }"
      end
      if prefixlen < 32
        @value = @value.mask( prefixlen )
      end
    end


    #
    # @return [String] the IPv4 address in its text representation.
    #
    def to_s
      @value.to_s
    end


    #
    # @return [Number] the IPv4 address in its numeric representation.
    #
    def to_i
      @value.to_i
    end


    def == other
      to_s == other.to_s
    end


    #
    # @return [Array]
    #    an array of decimal numbers converted from IP address.
    #
    def to_a
      to_s.split( "." ).collect do | each |
        each.to_i
      end
    end
    alias :to_array :to_a
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
