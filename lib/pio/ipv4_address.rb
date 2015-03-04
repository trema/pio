require 'forwardable'
require 'ipaddr'

module Pio
  # IPv4 Address
  class IPv4Address
    extend Forwardable

    # @return [IPAddr] value object instance of proxied IPAddr.
    attr_reader :value

    # Creates a {IPv4Address} instance object as a proxy to IPAddr class.
    #
    # @overload initialize(addr)
    #
    # @param [String|Number] addr
    #   an IPv4 address specified either as a String or Number.
    #
    # @raise [TypeError] invalid address if supplied argument is invalid
    #
    # @return [IPv4Address] self
    #   a proxy to IPAddr.
    def initialize(addr)
      case addr
      when Integer
        @value = IPAddr.new(addr, Socket::AF_INET)
      when String
        @value = IPAddr.new(addr)
      else
        @value = addr.value
      end
    end

    # @return [String] the IPv4 address in its text representation.
    def_delegator :value, :to_s

    # @return [Number] the IPv4 address in its numeric representation.
    def_delegator :value, :to_i

    # @return [Range] Creates a Range object for the network address.
    def_delegator :value, :to_range

    def_delegator :value, :==

    def eql?(other)
      @value == other.value
    end

    def hash
      to_s.hash
    end

    # @return [Number] prefix length of IPv4 address.
    def prefixlen
      netmask = to_range.first.to_i ^ to_range.last.to_i
      if netmask > 0
        32 - format('%b', netmask).length
      else
        32
      end
    end

    # @return [Array]
    #    an array of decimal numbers converted from IPv4 address.
    def to_a
      to_s.split('.').map(&:to_i)
    end

    # @return [Array]
    #    an array of decimal numbers converted from IPv4 address.
    def to_ary
      to_a
    end

    # Returns the IPv4 address masked with +masklen+.
    # @return [IPv4Address]
    def mask!(masklen)
      @value = @value.mask(masklen)
      self
    end
    alias_method :prefix!, :mask!

    # Returns the IPv4 address masked with +masklen+.
    # @return [IPv4Address]
    def mask(masklen)
      clone.mask!(masklen)
    end
    alias_method :prefix, :mask

    # @return [bool]
    #   Returns true if the address belongs to class A.
    def class_a?
      mask(1).to_s == '0.0.0.0'
    end

    # @return [bool]
    #   Returns true if the address belongs to class B.
    def class_b?
      mask(2).to_s == '128.0.0.0'
    end

    # @return [bool]
    #   Returns true if the address belongs to class C.
    def class_c?
      mask(3).to_s == '192.0.0.0'
    end

    # @return [bool]
    #   Returns true if the address belongs to class D.
    def class_d?
      mask(4).to_s == '224.0.0.0'
    end
    alias_method :multicast?, :class_d?

    # @return [bool]
    #   Returns true if the address belongs to class E.
    def class_e?
      mask(4).to_s == '240.0.0.0'
    end

    # @return [bool]
    #   Returns true if the address is unicast address.
    def unicast?
      class_a? || class_b? || class_c?
    end
  end
end
